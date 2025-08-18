Return-Path: <netdev+bounces-214785-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E12C3B2B38D
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 23:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8EADB7A735B
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 21:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B270421883E;
	Mon, 18 Aug 2025 21:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="ViMJTKmi"
X-Original-To: netdev@vger.kernel.org
Received: from sonic312-26.consmr.mail.ir2.yahoo.com (sonic312-26.consmr.mail.ir2.yahoo.com [77.238.178.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC63217F23
	for <netdev@vger.kernel.org>; Mon, 18 Aug 2025 21:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.238.178.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755553286; cv=none; b=JvyxvW7pHKSi5Q7/OOx7x9EQWlGunqDAjJprXS5hQgU/4UIR093bX1s7x/7TKBDdpxrJFxc+63J7WvRbWrFeYJS7dh71aq6J5NFCdPgH6ti+NCR0yYBqw0EThnjrBQg1nvZJOI1FGLeWI6hb9TN+vfGFZBhqy+cAykf/nX7u1Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755553286; c=relaxed/simple;
	bh=botz0FT0NiuU9WqIXD42BZw5R29ehrUR/78Y1xEbVRc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h72OVOcoKemRTGJweiEBuBXzr5yMw+LC/p0vXtpMB0Ky0yV6+sNZ6jIUtBbURKti2C3cHIzHGk/xZGpChMXA/Y0uoz1jiYSMaq+u/tWQ9eKRtG1D8rX7caKjZBQ1bWBw2hcX9MEed7iG90snOpFmT2veIhz7W87e8asG1YAbBi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gagniere.dev; spf=fail smtp.mailfrom=gagniere.dev; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=ViMJTKmi; arc=none smtp.client-ip=77.238.178.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gagniere.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gagniere.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1755553277; bh=K5JfjdXTe5Sps1PIuwcFEPVRm7PfXvCzrb9okxWQosg=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=ViMJTKmiNlkhGT0Q2lGJp1+CewLxambdPNRmvTo+rO3eeqUe75oWhPsNrtJsNtbdtVj2xQdFISJUi69DEBq/MN4r1EE2jZot83UHsQQIVKU8UazTilMeS+MUj4Nl3DVV1C1VkJKMfyce2Q4IzOE5bOzq3lb706GKnmAkmsuGiMywp3GQa2apRveWCKTbWyM2N+MuNGBaY6Fp7fpi9sRHaCqMyS1HanyHMnTbegNnsytBf7gmuic6SPyPxl080KaVuP8sCO+zWaUwd6Q+48Z2sVx3xvp81tvNeBX4Dx9PnZdvCX8P88rW42fO3L/W/7ZdI53Ty87JZpfjEunlPQGIVA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1755553277; bh=x+sgIpGZWPJFY6wYxcoXKm0cy3v/kT8pGhyX9HfYusk=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=G3CcaGlrEtZYLsxL/AwkbQkQuDy3AfQiBGeWYLykIp5cfj0k/LJYPiCfUUiBN6F/JhjM3XUD4ranrdYYO78bYeKMO9NT4qVZGybNS8Js/q2C8u7zj72A8s2IBrvGWZayY636YHlffJoaYmuOj+jwvkNmJoTbXv/YMkPheFQI9nvB/6jI0qEt8a0TRUOfP5+IFS4XkXgBWC9dZP2PDWa1VN4bPZ0JfKd/OvehYOZ36TcMHYFfxaVCMG6JKrJFw1bAyvDWGrMdcNh607PYkgWhn8HnYsGfObkFJRY2yjTnNa9I2jN/rgQxuwHP+2NqmvnS4JB/b6n3fPyx7TonFHCbwQ==
X-YMail-OSG: _rDGOfQVM1mjFL2kYhzXkC0cNEvnjPxO9rH8Zgk6TJQpowSe8lOO_nzuAnd1RLz
 y0dotewveT6P2eWOjQf_v5XPJ0voT6HHlo4Kb8eEiJff89RfNZ5k.TcWHp33joB49Gyhj.lKOpbF
 5.9APPhyIq1tFgylujo53qGutSIvbMnVjt0obJvBofRZXOBMAbfnqVN3xuhT5JWpB4F3TZd28DeL
 o18A3y80XCbktMwngGvBHEHOLgrVJIKdglS_3Bqox95zkJgbNNtHCfg8QN5bf4z5yv2D7S26iobD
 R0ozQHBegsNseO94nCZME.aYNB7JVbkprRfN.qKc7nkiIUL_ANHafZvFO6.XJXC4a3kPQLsY8V_2
 cHWDUd1S1IrZiGdLj6Z3UP8G01S9bD3c735OpaOOZw5Hi8SJ5YBtpVg2hSYNtiCkawHopQkv1Pky
 Ysr2kzwZkTM0P347up8BbcZ57HbNcV0SxtNX1e_tykNKjpKTv7NkduPaP2Zz9jFdJMOmPiiNaU8p
 M1uhA7A6O7CISyO2JNmVu_NyJj4bqsQe3MSu6AA2HQxfySN1KRXaH7NB77a2MrwTIQV0fh61gDyY
 CbkAdtciG2JWRd.8hbM9N5rpr7jdokygqGDjT__F9e3QLBr77dFtmeXaLrhD.RpVHgt.Wa1GUCKm
 lzzY3mHj5e2pmYd5.fViAk3JLeWFR1Fu71QTFzGK3N9ohkBkvg0HH3pK5l6zIShGUAnE_FgRqFfO
 wnokhVzfZ4ArBCA.G5AATJIS.kWqjVijZz2t_0wjQlGj3ghxk3UGi3S1bTM9IsB1qjiS0WLiSiKA
 l7Mn4woulQcIPZkM8rFPgA2no7GuOT4TZSwbjeAT4z3bjKxqiVBN5Sxgt0C8s8xrjKXc6JdN1PzC
 sYTX9AEMqRTZMV65s5oRm0mB3L62STBDJyOl8D5PyPUAEh8hk66n.5nlWA9UoHXllpwxCP3Q5.MZ
 IKJ_XhYgGBNP4oITjb8QsI78HUC0V7hBoBCo.YLU..TgCAthLWR4K8D0hnOHZsSad5.uobxiN.M7
 jQdfoRCr4X_nN89DWwXYUTweo10V0lxsSqqcu4HEaYR.y.385Ivd.qude2ebs5TtZn_bsUCPXuuZ
 BFWMUJEHVOo2bToURyksbRR8qeVudxMvoFmSpSX99KunFE6iAoD.Uc.UvYSLtVUR31dJ87GVrjQB
 2c8F1zka0Ia9_jPj9nLLHPUGwXT3PLZP5KODhjlgdpGCnpYpyQ9Qmsi6yIkxHLjubq21O.wVtCjf
 R4mskQHzIxu6ZGab8c3hIUVIl42pYvcEIG6mkBOXBd5Dd2FS_qbil_PRUuZU3Ud0EuG5qQUCRJ1A
 Yrkqo_X3x3T5bKCA_glN0SPVqfaA.WOyhnvonufI8kF12TdZJVdVliEKZr3srzxy7sUBS6iXqYwq
 fMmWiFxEtC6teRfCmL5_O9FNoc5GR79JTibyMDgvKGJNv9X_JeEwnCo16aHVrJUpwucxRulCvhwU
 Vje_X6c8W4EJpGTlkevL.nPynu4GZJnE4ggC.vQ6WUSJgwVhyT0gbmF.zGfQp_pgUPKG8bmso1F8
 NDCSZHXu3kP3.qLoHZNKRwImNoxJ6Ajn7Qo71XPIkRwbwl_EEpjRv3qvB9bD_mUzQ3RFQDrHVYky
 P9WeAS8VcQEzYZ.LciHj..I57bGjxtrxRGCCNkYcqlMeJsWC5ij.eoEZ7.WVMIncRkNRBM1k9Wra
 7qsUcxNECmsYWPrRZUu49Ym2L66rLr8lPCspuT.YMYr01AijpKMwwz_hqzwBQHFJRWliyvTO9W99
 ZiRLcCqcOaslBbtJV5149KQghUNbkVtLWf.5TbqzpXBT8NueaPo9rozi2.YxLdx4Id9JHD3os_fz
 7uIcYJOZQ5xKZlmfMPDFgZjb1h8v6x3DST4zX2RJwKnIQensCLpXjhf.gPMtYIM4Qnt67Xxd9fMb
 qkiD6EoesAjsLLZONJDv2mQBnWx3agojXY56gg95xQMJpLLqQSzl1c_xhnDdErDxU0NBatstcbaT
 TLfpA804fYbaINYCpWJjh.IasXthgMeguhVnTXqSy5RdVtZ1wkXM0Ur1_U0N6eOOgyrfBC2sCP62
 oeB_1T2kJpmo5xvvDIfKB3ZuSqOnx2t8uz3RUizmh3OETnFrIlo979ibYwhTUWtuGMpnTtkagAE_
 m4WgO2e0tc9Nenlw7LPs.xDNV4EsB0T.S0DZc28SKNdvezF7VH0rsSHZhLSXvuzn_T5VkcZHwvkK
 _HAISpQjIvFjsAdkwX5zy3U761cyr0p5oK5NmjhB1CqdTdKD03qAaw2sca85aKQ--
X-Sonic-MF: <antoine@gagniere.dev>
X-Sonic-ID: 5066edb9-4f7b-4393-85f5-d0598e766b99
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ir2.yahoo.com with HTTP; Mon, 18 Aug 2025 21:41:17 +0000
Received: by hermes--production-ir2-858bd4ff7b-mp79t (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 5508fcfd494b94e06b4a8396594c10b4;
          Mon, 18 Aug 2025 21:31:05 +0000 (UTC)
From: Antoine Gagniere <antoine@gagniere.dev>
To: vadim.fedorenko@linux.dev
Cc: antoine@gagniere.dev,
	jonathan.lemon@gmail.com,
	kuba@kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH] ptp: ocp: Fix PCI delay estimation
Date: Mon, 18 Aug 2025 23:31:04 +0200
Message-ID: <20250818213104.34351-1-antoine@gagniere.dev>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <6848f9cc-a713-4eee-abf2-e4159fea50c2@linux.dev>
References: <6848f9cc-a713-4eee-abf2-e4159fea50c2@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

>>   static void
>>   ptp_ocp_estimate_pci_timing(struct ptp_ocp *bp)
>>   {
>> -	ktime_t start, end, delay = U64_MAX;
>> +	ktime_t start, end;
>> +	s64 delay_ns = U32_MAX; /* 4.29 seconds is high enough */
>>   	u32 ctrl;
>>   	int i;
>>
>> @@ -1568,15 +1569,16 @@ ptp_ocp_estimate_pci_timing(struct ptp_ocp *bp)
>>
>>   		iowrite32(ctrl, &bp->reg->ctrl);
>>
>> -		start = ktime_get_raw_ns();
>> +		start = ktime_get_raw();
>>
>>   		ctrl = ioread32(&bp->reg->ctrl);
>>
>> -		end = ktime_get_raw_ns();
>> +		end = ktime_get_raw();
>>
>> -		delay = min(delay, end - start);
>> +		delay_ns = min(delay_ns, ktime_to_ns(end - start));
>>   	}
>> -	bp->ts_window_adjust = (delay >> 5) * 3;
>> +	delay_ns = max(0, delay_ns);0
>
> I don't believe we can get a negative value from
> ktime_to_ns(end - start), and that means that delay_ns will always be
> positive and there is no need for the last max().

You are correct, ktime is monotonic, this was an excess of zeal
on my part.


> JFYI, for the next version could you please organize the commit message
> to fit into 80 chars per line and specify net tree as well as patch
> which you believe introduced the problem using Fixes tag.
>
> More details on formatting can be found at
> https://docs.kernel.org/process/submitting-patches.html#submittingpatches

Thanks for the link, I was looking for such documentation but somehow missed this page

Will attempt a v2 later this week

