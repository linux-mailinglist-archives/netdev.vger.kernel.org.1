Return-Path: <netdev+bounces-246680-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D3029CF053C
	for <lists+netdev@lfdr.de>; Sat, 03 Jan 2026 20:42:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8CEC5300B80E
	for <lists+netdev@lfdr.de>; Sat,  3 Jan 2026 19:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E500A23F42D;
	Sat,  3 Jan 2026 19:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="oCtd5L5x"
X-Original-To: netdev@vger.kernel.org
Received: from sonic303-22.consmr.mail.ne1.yahoo.com (sonic303-22.consmr.mail.ne1.yahoo.com [66.163.188.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7223A1E72
	for <netdev@vger.kernel.org>; Sat,  3 Jan 2026 19:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.188.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767469362; cv=none; b=eon6gtd7DzZa+Ky4cKAWjoIPqJe0oAyQECII1UfQeB084WHTSYhmrmvis8lHyPbtMQy9/bwabcQ4dhJw+7g+CnbpFHxEEKPctdom7alpF2eFEJ1QujxvCZiM1LPU1p04AqFPVD9NkeZDTOlUpMEHPs0ZtESp/ZS/xMI2CSp+vIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767469362; c=relaxed/simple;
	bh=VKEJ9WHs7DJO4rl7zYd3y9gPDSLlySJtr7BxEAsKM3E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tsLDiM+r1HwhJIezRDySyYQLfU8XPo3szqmoN0FJJhBLTcThG2FzVuiFWcjY3NvTdt9ZVfx+OH5ku+g4L7AWXkXzGF3b9yUg9xhtpepHEqVSAj+GOcgxIUUsHMyZ32j202z89DkyuodVaD1X9+prdZPNQawshdHcLV2ZejqN5v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=oCtd5L5x; arc=none smtp.client-ip=66.163.188.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1767469360; bh=oIbJAeJTdK8BgUzvSNG65U+Yoc/aJMRpOPLcceF8C/o=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=oCtd5L5xVHVNQeIQM/SZsXe6pXkmmcR/jQt7OC2le+AEzkBnBEL729+Jbw93G8J0cIEKu/6dA+/uqGjk/kW91z3LygPKpvHBano+K/rfcKMMUykj6cKhkRbdYwGDp/kyL4gKS6Xpx0QOiVxL73EIcT2+odoHW7ibUqXDlz/3uGWnkpu7cafSjCoHEbw/RgpYcluflXX1M/HRsqjMW8szU6h5Za2ZjEd/EHpgE62tFCj4zrNzUmTMk2IrISRMwzuueKIfwwuU5bfgVMhqrK+6mkxdeq6gLuqd4qtWvzrp8N/oEDoWbMceeEWeAsBVp+Wo9u0dYL2mJAG+/KVuvDOV2w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1767469360; bh=1/SO2wPp+771Me9tr0OTt9F0fxymmP1hBgNF3hI0fKk=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=ZOg1OpUoYwiuJdTPYE3Z0UPUB2vVCRZXIz8JFJMK7APa/lev8VlM8VQ7nZJwURWcH5dSOPI0piLVPxNqcKi8hYkrXPEe7ncimIVed3zPUZ3OpBAoht551fL/7lpyKiGf5i3s3wpWXGVySdyRpnE7zo5bk7USL9N2mZszESoZDF6LHWIWGcn33FWA2n6jOkVl6ikgBjjkNTicaOHIe66VMvOwn5s5SSmlxt66mbwIVM/DhtiLwDNN24Iir/KsrkDBrgFLywb2lxEN2alkTqFzBU9gP/4aFJ7z4U97mTFqPo9Ws6pRx3dCtF5BBXcXvXgatJFT6Stauby/jYxs/louOA==
X-YMail-OSG: Ayv9sNoVM1nKtYnE9ukWPfvtMQwJyJg4HbCBU0_uPnK6GjJpZTO5zVoIbTrvjtU
 0r0dtLNRZpNGwWWBZMjlWsQAGnA4AqB9mftrHeXulwiHx5bkWWPZCDa5n0xvqPtChx3ll1Cy.2bg
 sGoPY1V73XTe9XFc922a1cd0h1_3lYOcA6KtFWvUs72r.IMK3k.myV8nwjgicH5ASygqwRMCBnzZ
 pcNmF9pFGrc.oO3HiuT7I209My8B4uLwJZKC2XFByoliAoj8eoHpGGuNpEa0ln9IqTdtFP671qxb
 Z0_cak.x4uBHgTex9M1b3G5aVp2wrKsunUPVMSu0g4naujfEUHkzgAIksFPKaJXSm4G8LWpWgczo
 qkNXYZk4CHSTA7rgukyGqHlFsfjeF3DE0Me8KNfJf4LlY.H1AJ2ie632LkumndFmMQ8RYrj0LTNn
 BLSAPNUsPe9zxl5.51vwVUmaIQgxyD5BRmX6gOqBjun4duXTJMOGuSnwHfqiFPXCP343_0.A0XGA
 MFzJsdmXi1sHKJkx9woRZF6DiEBTsvYFsQoNnsMqMd33ptoxMapqgPaaK19S0mCVaPKCENUfANmf
 L0p86jIngXbPAoQCYrCm.KV8hLwhGMDhU24fSQazF73paOngUOZ2Y0gD87Mwf0UhieeKPHiR7IEb
 vzsCDoEBu5b46..vyi1fIzlz53vpsumcGZe5RtQNEn864BzOW8pxAcMT0dy41xJP23.m4B.yqw7A
 WYmaVwgs6.8lSZ10FxJKlpNqn3OT49nBKjomGVviAQHTW6rlSuyqVAuBrpDQt6nkPupbJs_igCpU
 uUG42VdMl6DQPe4iDZlTqNNjzCjdfQwFtow_l3E3fbNY7XbjD9l0YDea8T8oH.wwVsMuChZ0QtWe
 VWnmSCjANGXvhbQ.zSNVoMVpG3mIH8Hc0Jbu9SeYwUeXq0ld_t8xv6_3sQI37xwZ0J5.ogAF6P6O
 WnIlPR.UlmqK_voEIEqYFoqt1WHGkzQT1o5o.HxKz1t9e5Ih4gIqjFJU0gfgAOdBvmb5Gd9FXlKw
 2w4xOtvxGbgWObnerSr_I3dtkR7rK8ZwcAwdbke_CoFMksvc1mKyWZFj2D7UbWoPhRUiHg6UyDu.
 8TIMBHs5MxcsI_XvDSeUrOkZlIMnAHZvr266l34fqe5VvnListmtSXqQYtBAvpZcXLOm3VYVJbZo
 umGqN6VgzT1C9fTD9tfFu48kz9dudZCVFaRLWoiEdMYYjCIMPKJdKREysZOYU6eoYpjD7_wNX42V
 yM2TvvaVqzun9otZ3vDqUXdFjJoZ8Wr6KcL6DugW6pGQtkYY9UibZYzeVNbAIv4OjUlILgu9F3y8
 BwyNUSERZmPNOqzrTYuKsmRB7663cMTbDPGdPPnf15NT94BzUhbb6FZ131lg7BQrUU63XiLZGuue
 WGtrCUX1xDmBNrPQuFJXHwGMBokCAnUK31V0ls6F0gWwgqAnEdUVWrQnefEJGoYZgQAoxasy5mpJ
 zwRVUWjk1VUtWGtE_wkmj.GUZBDlGIJZScBhmtnG05Y5FP.CSDmC1c0P7tyMRsXPAiKE90eJRIcd
 bumdHdsb3ck.rVjl7RVUa_Q3pdELlPA4j27RHXpqRV6IkSFzmWtcfJG8RF9o.4eImVlRPwq67rsA
 B38ExuUvkkFzh2.RrmrJBg5PmFOqJHUlrkGPjz5sDmdexeIwnilYYzXR.4fZDFE5VrCo7RjAsDqB
 mRwqDSTRaCVceXSxnQ04l237Q612YBI84rVrBqI0M6bgnZEWkd692HB5BxKx4DI_NtwTNcy1lelO
 e4TDP_n.tQD5iII8QRUetc53WD4om66VpG9Ed7uI7RWPiDztupuhPA4n3CvX6Eh36prEikXe0pLo
 EuHqY3bJNGq1tA4KI8G7VXCBHjqLLp58eNR9Y2l9_TBzm8nBg9FUG.7E3EPhOsF2K_WQTnfJUvaG
 MJffybIXRXQXFMI8SIzNuxPaRPbQXhjCFROYeG1Jsvo.3gvBtBIWdMDOpSjZzZu9ineip0FVd.Lo
 PdelhmVUiKfl56vTGzWvqqwscnZ1gkLAgzyee5kaeREYJAM3uIzAZSeGHFAVdmUjO1L0DLpbFsuR
 R_nDXvRlNrraKhy4bI2fAveagSYpDO8Zo9uKAVnEG3MSIlZRFvgO8jERKvuwOGKm1zXXJY4OABHz
 R.6R3SpLrDQw.Bgk7ShrI3dnyMgHbHo.Axp0igM88UOiVBu261S_DfENJz3wAY2QK5NSEG.HOxwt
 XMl9hzTJpv21rY4yfRZGD4PW6rFvgM5qsBhle4wj1OENSFDmRj8qM3dKk5EzkXWQfBBkYDpg2Yxd
 1e2cs1191RoI7MJvtZ6BIaw--
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: fe3a4e69-336b-40d8-b30b-b99918dac6b5
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ne1.yahoo.com with HTTP; Sat, 3 Jan 2026 19:42:40 +0000
Received: by hermes--production-ir2-7679c5bc-jd2qw (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 493a83f7f5ffaecd3d7e73a31c628506;
          Sat, 03 Jan 2026 19:12:14 +0000 (UTC)
Message-ID: <714df4e3-224c-4999-8132-fdbee4cfaec8@yahoo.com>
Date: Sat, 3 Jan 2026 20:12:10 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2] net: dsa: realtek: rtl8365mb: remove ifOutDiscards from
 rx_packets
To: Andrew Lunn <andrew@lunn.ch>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
 "edumazet@google.com" <edumazet@google.com>,
 "alsi@bang-olufsen.dk" <alsi@bang-olufsen.dk>,
 "olteanv@gmail.com" <olteanv@gmail.com>, "kuba@kernel.org"
 <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
 "davem@davemloft.net" <davem@davemloft.net>
References: <2114795695.8721689.1763312184906.ref@mail.yahoo.com>
 <2114795695.8721689.1763312184906@mail.yahoo.com>
 <234545199.8734622.1763313511799@mail.yahoo.com>
 <1c0ee3d4-2b24-48ea-b34f-b5653abe11d4@lunn.ch>
Content-Language: pl
From: Mieczyslaw Nalewaj <namiltd@yahoo.com>
In-Reply-To: <1c0ee3d4-2b24-48ea-b34f-b5653abe11d4@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.24866 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

rx_packets should report the number of frames successfully received: 
unicast + multicast + broadcast. Subtracting ifOutDiscards (a TX 
counter) is incorrect and can undercount RX packets. RX drops are 
already reported via rx_dropped (e.g. etherStatsDropEvents), so there is 
no need to adjust rx_packets. This patch removes the subtraction of 
ifOutDiscards from rx_packets in rtl8365mb_stats_update(). Fixes: 
4af2950c50c8634ed2865cf81e607034f78b84aa ("net: dsa: realtek-smi: add 
rtl8365mb subdriver for RTL8365MB-VC") Signed-off-by: Mieczyslaw Nalewaj 
<namiltd@yahoo.com> --- drivers/net/dsa/realtek/rtl8365mb.c | 3 +-- 1 
file changed, 1 insertion(+), 2 deletions(-) --- 
a/drivers/net/dsa/realtek/rtl8365mb.c +++ 
b/drivers/net/dsa/realtek/rtl8365mb.c @@ -2180,8 +2180,7 @@ static void 
rtl8365mb_stats_update(struc stats->rx_packets = 
cnt[RTL8365MB_MIB_ifInUcastPkts] + cnt[RTL8365MB_MIB_ifInMulticastPkts] 
+ - cnt[RTL8365MB_MIB_ifInBroadcastPkts] - - 
cnt[RTL8365MB_MIB_ifOutDiscards]; + 
cnt[RTL8365MB_MIB_ifInBroadcastPkts]; stats->tx_packets = 
cnt[RTL8365MB_MIB_ifOutUcastPkts] + cnt[RTL8365MB_MIB_ifOutMulticastPkts] +


