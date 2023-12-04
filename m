Return-Path: <netdev+bounces-53673-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F808040FD
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 22:28:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32EF71C20A5A
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 21:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B47381BE;
	Mon,  4 Dec 2023 21:28:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD1CBB6
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 13:28:50 -0800 (PST)
Received: from merlin by mail1.merlins.org with local (Exim 4.94.2 #2)
	id 1rAGUj-0001wP-VU by authid <merlin>; Mon, 04 Dec 2023 13:28:49 -0800
Date: Mon, 4 Dec 2023 13:28:49 -0800
From: Marc MERLIN <marc@merlins.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	intel-wired-lan@lists.osuosl.org,
	Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [RFC PATCH] net: ethtool: do runtime PM outside RTNL
Message-ID: <20231204212849.GA25864@merlins.org>
References: <20231204200710.40c291e60cea.I2deb5804ef1739a2af307283d320ef7d82456494@changeid>
 <20231204200038.GA9330@merlins.org>
 <a6ac887f7ce8af0235558752d0c781b817f1795a.camel@sipsolutions.net>
 <20231204203622.GB9330@merlins.org>
 <24577c9b8b4d398fe34bd756354c33b80cf67720.camel@sipsolutions.net>
 <20231204205439.GA32680@merlins.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231204205439.GA32680@merlins.org>
X-Sysadmin: BOFH
X-URL: http://marc.merlins.org/
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: marc@merlins.org

On Mon, Dec 04, 2023 at 12:54:39PM -0800, Marc MERLIN wrote:
> On Mon, Dec 04, 2023 at 09:40:08PM +0100, Johannes Berg wrote:
> > This one's still the problem, so I guess my 2-line hack didn't do
> > anything.
> 
> sorry, I wasn't clear, this was the last hang before your patch. I
> wanted to make sure it matched your analysis, which it seems to, so
> that's good.  I now understand that the order in printk is not actually
> the order of who is at fault.
> I'm testing your patch now, will let you know ASAP

Well. Good news. So far so good.

sauron:~# ethtool -i enp11s0
driver: igc
version: 6.6.4-amd64-volpre-sysrq-202312
firmware-version: 1073:8754
expansion-rom-version: 
bus-info: 0000:0b:00.0
supports-statistics: yes
supports-test: yes
supports-eeprom-access: yes
supports-register-dump: yes
supports-priv-flags: yes

sauron:~# iwconfig wlp9s0
wlp9s0    IEEE 802.11  ESSID:"magicnet"  
          Mode:Managed  Frequency:5.2 GHz  Access Point: E0:63:DA:28:03:67   
          Bit Rate=866.7 Mb/s   Tx-Power=22 dBm   
          Retry short limit:7   RTS thr:off   Fragment thr:off
          Encryption key:off
          Power Management:off
          Link Quality=70/70  Signal level=-40 dBm  
          Rx invalid nwid:0  Rx invalid crypt:0  Rx invalid frag:0
          Tx excessive retries:0  Invalid misc:992   Missed beacon:0

sauron:~# lspci | grep -i net
09:00.0 Network controller: Intel Corporation Wi-Fi 6 AX210/AX211/AX411 160MHz (rev 1a)
0b:00.0 Ethernet controller: Intel Corporation Ethernet Controller I225-LM (rev 03)

It's unfortunate that nouveau doesn't seem to support the nvidia chip at all, not even
well enough to turn it off, but thankfully I can do this via
  echo 'auto' > '/sys/bus/pci/devices/0000:01:00.0/power/control'

For power, I was able to get it to idle at 13W with tlp powering down chips to slow
speeds, and the screen fairly dim. It's not great but it's cmoparable to the P73, so
close enough.

The weird PME loops I attached in the last Email would also butn batteries on my P73
without hanging it. Your patch may have fixed that too. If so, thank you
(will report if I see the PME stuff again).

Either way, I'm in much better shape right now on a laptop I was about
to return after having spent 3 days of effort on it, so a heartfelt thank you!

Where do you we go from here? Is the patch obviously good/safe, or do we
need to narrow things down/test some more?

Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/  

