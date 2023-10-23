Return-Path: <netdev+bounces-43483-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C95277D38EA
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 16:06:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 052A61C2098F
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 14:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82CB01B273;
	Mon, 23 Oct 2023 14:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.pl header.i=@yandex.pl header.b="IsraLzSf"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819342586
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 14:06:18 +0000 (UTC)
X-Greylist: delayed 418 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 23 Oct 2023 07:06:12 PDT
Received: from forward201a.mail.yandex.net (forward201a.mail.yandex.net [178.154.239.92])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F62310E2
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 07:06:11 -0700 (PDT)
Received: from forward102a.mail.yandex.net (forward102a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d102])
	by forward201a.mail.yandex.net (Yandex) with ESMTP id B122564CC9
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 16:59:17 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-18.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-18.vla.yp-c.yandex.net [IPv6:2a02:6b8:c0d:3fa3:0:640:cb15:0])
	by forward102a.mail.yandex.net (Yandex) with ESMTP id 2ED5D60AAA;
	Mon, 23 Oct 2023 16:59:12 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-18.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id AxNCxq5DSGk0-rI2WOUmK;
	Mon, 23 Oct 2023 16:59:11 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.pl; s=mail;
	t=1698069551; bh=iI33+/rzn5sH4ynUVA/931uPDe4P3bhyBCWex0PQDDY=;
	h=Cc:Subject:From:To:Date:Message-ID;
	b=IsraLzSfTHThKd9o2YP1Wpa39MkkF2SgSn8glE43hVvHfvK/UdTlF0rPgdNEZ4qAJ
	 PA3Rav+qQEx/a/GCpK33bZP3L+g1+8achlRF+lWdORKgtKmZ3mBw/OA7KJJVIwT7E2
	 SCzlCcQL0d2a3XsgsZFD4C7Q6bUM38DyUDJgZgwE=
Authentication-Results: mail-nwsmtp-smtp-production-main-18.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.pl
Message-ID: <e28faa37-549d-4c49-824f-1d0dfbfb9538@yandex.pl>
Date: Mon, 23 Oct 2023 15:59:09 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: netdev@vger.kernel.org
Content-Language: en-US-large
From: Michal Soltys <msoltyspl@yandex.pl>
Subject: [QUESTION] potential issue - unusual drops on XL710 (40gbit) cards
 with ksoftirqd hogging one of cpus near 100%
Cc: =?UTF-8?Q?Rafa=C5=82_Golcz?= <rgl@touk.pl>, Piotr Przybylski <ppr@touk.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

A while ago we have noticed some unusual RX drops during more busy day 
periods (but nowhere near hitting any hardware limits) on our production 
edge servers. More details on their usage below.

First the hardware in question:

"older" servers:
Huawei FusionServer RH1288 V3 / 40x Intel(R) Xeon(R) CPU E5-2640 v4

"newer" servers:
Huawei FusionServer Pro 1288H V5 / 40x Intel(R) Xeon(R) Gold 5115

In both cases the servers have 512 GB ram and are using two XL710 40GbE 
cards in 802.3ad bond (the traffic is very well spread out).

Network card details:

Intel Corporation Ethernet Controller XL710 for 40GbE QSFP+ (rev 02)

Driver info as reported by ethtool same for both types:

driver: i40e
firmware-version: 8.60 0x8000bd5f 1.3140.0
or
firmware-version: 8.60 0x8000bd85 1.3140.0

These are running under Ubuntu 20.04.6 LTS server with 5.15 kernels 
(although they differ by minor versions, the issue by now happened on 
most of those).

The servers are doing content delivery work, mostly sending the data, 
primarily from the page cache. At the busiest periods the traffic 
approaches roughly ~50gbit per server across those 2 bonded network 
cards (outbound traffic). Inbound traffic in comparison is a fraction of 
that, reaching maybe 1gbit on average.

The traffic is handled via Open Resty (nginx) with additional tr/edge 
logic coded in lua. When everything is fine, we have:

- outbound 30-50gbit spread across both NICs
- inbound 500mbit-1gbit
- NET_RX softirqs averaging ~20k/s per cpu
- NET_TX softirqs averaging 5-10/s per cpu
- no packet drops
- cpu usage around ~10%-20% per core
- ram used by nginx processes and the rest of the system up to around 15g
- the rest of the ram in practice used as a page cache

Sometimes (once per few days, on random of those servers) we have weird 
anomaly happening during the busy hours:

- lasts around 10-15 minutes, starts suddenly and ends suddenly as well
- on one of the cpus we get the following anomalies:
   - NET_RX softirqs drop to ~1k/s
   - NET_TX softirqs rise to ~500-1k/s
   - ksoftirqd hogs that particular cpu at >90% usage
- significant packet drop on the inbound side - roughly around 10-20% 
incoming packets
- lots of nginx context switches
- aggressively reclaimed page cache - up to ~200 GB memory is reclaimed 
and immediately start filling up again with the data normally served by 
those servers
- the actual memory used by nginx/userland rises a tiny bit by ~1 GB 
while that happens

 From things we know:

- none of the network cards ever reach their theoretical capability, as 
the traffic is well spread across them - when the issues happen it's 
around 20-25gbit/card
- we are not saturating inter-socket QPI links
- this happens and stops happening pretty much suddenly
- the TX side remains w/o drop issues
- this has been happening since the december 2022, but it's hard to 
pinpoint the reason at this moment
- we have system-wide perf dumps from the period when it happens (see 
the link at the end)

Sorry for a bit chaotic writeup. At this point we are a bit out of ideas 
how to debug it further (and what data to provide to pinpoint the issue).

- is it perhaps a known issue with kernels around 5.15 and/or these 
network cards and/or their drivers ?
- any pointers what else (besides kernel/xl710/driver) could be an issue ?
- any ideas how to debug it further
- we have system-wide perf dumps from the period when it happens, if 
that would be useful for further analysis; any assistance would be 
greately appreciated

Link to aforementioned perf dump:
https://drive.google.com/file/d/11qFgRP-r03Oj42V_fAgQBp2ebJ1d4YBW/view

 From the quick check it looks like we spend a lot of time in RX path in
__tcp_push_pending_frames()

