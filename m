Return-Path: <netdev+bounces-228572-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 80722BCEE58
	for <lists+netdev@lfdr.de>; Sat, 11 Oct 2025 03:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 76D614E2033
	for <lists+netdev@lfdr.de>; Sat, 11 Oct 2025 01:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0509613C8E8;
	Sat, 11 Oct 2025 01:56:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7B786340
	for <netdev@vger.kernel.org>; Sat, 11 Oct 2025 01:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760147760; cv=none; b=VSsTkj31ZAyjXV3b4eibFzSf2+9882ABKwL5EciaKMRmC42L++LqbY5q932pQghrVLUglY9/G3q/r6NtDmrBUtEt5cybUEBx7/bdjGm2T1LpO+GWoYgc5vElk39apZFWkrlp7JuScEsgoBh5N+N72Hf9uzGz4/5d5l0D4A81hvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760147760; c=relaxed/simple;
	bh=PbEnz6iVzBDD/GelUjaRS4hmgZVEBJsUypv4E9h+LdU=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=Iz3JD8v2sLQgsbjcYK9V+lVKUfxSUXDOfQljeFatXjXx/nL+nbIa0jj95AMJt6xjOG9iODEzqzJo7ITl8aJBLGKhITQMzGUmNCrfPxicqLYunhaVLkux8sh5FG9YW6WVfGTTtUaqrgxo1fIGcoDD1lX2NHS3pPBrV7LLr8l/bOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:Yeas10t1760147620t064t61329
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [36.27.111.193])
X-QQ-SSF:0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 10432737734272836812
To: "'Andrew Lunn'" <andrew@lunn.ch>
Cc: "'Jakub Kicinski'" <kuba@kernel.org>,
	<netdev@vger.kernel.org>,
	"'Andrew Lunn'" <andrew+netdev@lunn.ch>,
	"'David S. Miller'" <davem@davemloft.net>,
	"'Eric Dumazet'" <edumazet@google.com>,
	"'Paolo Abeni'" <pabeni@redhat.com>,
	"'Simon Horman'" <horms@kernel.org>,
	"'Russell King \(Oracle\)'" <rmk+kernel@armlinux.org.uk>,
	"'Mengyuan Lou'" <mengyuanlou@net-swift.com>
References: <20250928093923.30456-1-jiawenwu@trustnetic.com> <20250928093923.30456-3-jiawenwu@trustnetic.com> <20250929183946.0426153d@kernel.org> <000301dc39ba$55739250$005ab6f0$@trustnetic.com> <f76ed32e-b007-484c-a228-4b7774a49020@lunn.ch>
In-Reply-To: <f76ed32e-b007-484c-a228-4b7774a49020@lunn.ch>
Subject: RE: [PATCH net-next 2/3] net: txgbe: optimize the flow to setup PHY for AML devices
Date: Sat, 11 Oct 2025 09:53:39 +0800
Message-ID: <002201dc3a51$dd3b1130$97b13390$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQF9Ncx3ddJxbS4YFASGoFm3bIwFPAGVefx/An6Z7FsBfYumBgJX3gk5tTro9ZA=
Content-Language: zh-cn
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MjlOSqg8Riw0e687AUBDnR+5n6bNnpkmjStIvLK7yOe6aM62SQtZ7laK
	iGKg7sFcuBQF8LDPTBV5sku4CKw9NN4mGAi2HgJ5GdR5qh2zjVzh8Ppfit9hTjNdBlFytFm
	sCfpmpR5Ii0C1jpCq9dYGqBgDVCUv3431G7Ugyi+rGZ8tO9ZW2+uQStjRU4I+cX1RR0fc6G
	oSwgV8zOb4EOogLyj0ynS2MuwAxanYNB0MjbD5lCAKj47rTf140rAaEQwez6sQH2G8kZPXu
	nIRN1pOalunI52LZkpsKK73PxBxoLZJaChwW1Kh/9ok7F0H1RsnZUahFmWI4vkQvcf8VYbr
	3PT/zfrx8vSLRlBr8xNpkkaIX4Vy17Kj1v7e4k487I7NPM2SsVTCWs1vVqSzFkH6V5IDGkE
	GLwLPUy4olnwAkKJ9AW0xfr7AEpc7HsjrwDV5i4uJx9YUcLhxLpABprXSQ/0z2ALfyVS0yS
	s0x21cIc6CEMoFdK2KIMjlJu0BK87nvSPiKRDweHAA0TIOMdtW8SnqjNsfu+EYTjWQGDDSW
	mZcbY3s4RKh35LUVH5v8bdn8gex0djM9syenN8zaHStU08PiM7fwIMXjFC12OQli3fwxQqB
	zDe6idu8RUlS2sF/T5VA4Y0rY5nnyjuVJI7iQYA6KD/YKPQ7H3yKN2bifFUAxmMnWbkxweo
	sS8qzS4fTnBmjBWzXYtHxe9mMX8ouBlBcEc6HD5Mw7Oov0clehsojozYv14/pKrxWwFVwTY
	e78oRej0tHyc2tFkGoUig8Zfbft8L9J/aOdKqeBOoCebO5yAPtAD7uFB4L5AUoSNgkTKe/u
	WMcd3Clze/NCCmbBXVDAay5V/cqVkmxAVJt/HASweuuiEtXGb2ZLusM1apy5rgA8P75q1nL
	W+QTSAW4Ty+iWRBAj/YtSBB0yBRE16fmiLd0VJuLEcuQef/uWyzhc5mP8+yTHAgKVp/Gsqx
	f0GZGbZNJ/g8ZGYO1gtyxkvlHmkCWSdLyUTkhj0BpJJf94/snBrSGhVqifmz472owAbeywk
	X4hbfbATqeuFfEi69eCd24UplQPPw=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0

On Fri, Oct 10, 2025 9:52 PM, Andrew Lunn wrote:
> On Fri, Oct 10, 2025 at 03:48:57PM +0800, Jiawen Wu wrote:
> > On Tue, Sep 30, 2025 9:40 AM, Jakub Kicinski wrote:
> > > On Sun, 28 Sep 2025 17:39:22 +0800 Jiawen Wu wrote:
> > > > To adapt to new firmware for AML devices, the driver should send the
> > > > "SET_LINK_CMD" to the firmware only once when switching PHY interface
> > > > mode. And the unknown link speed is permitted in the mailbox buffer. The
> > > > firmware will configure the PHY completely when the conditions are met.
> > >
> > > Could you mention what the TXGBE_GPIOBIT_3 does, since you're removing
> > > it all over the place?
> >
> > Okay. It is used for RX signal, which indicate that PHY should be re-configured.
> > Now we remove it from the driver, let the firmware to configure PHY completely.
> 
> Does this rely on new firmware? Or has the firmware always configured
> the PHY, and then the driver reconfigures it?

Driver does not configure PHY, it just send the command to firmware when
switching PHY interface. For the old firmware,  the PHY is configured only when
"SET_LINK_CMD" is received. But the PHY would not be completely configured if RX
signal lost. So the driver will send the command when TXGBE_GPIOBIT_3 interrupt
occurs. For the new firmware, it will automatically configure PHY when RX signal
arrives.


