Return-Path: <netdev+bounces-142449-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 608799BF396
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 17:50:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0B8DB21A94
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 16:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B74A51DFE33;
	Wed,  6 Nov 2024 16:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="NoRS6/0u"
X-Original-To: netdev@vger.kernel.org
Received: from sonic303-2.consmr.mail.bf2.yahoo.com (sonic303-2.consmr.mail.bf2.yahoo.com [74.6.131.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B60484039
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 16:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.131.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730911832; cv=none; b=c0eCymoJISeryxF+6WnPeDJbbqS+vkT1caDlwjkGPD/BlAIn0SKkxlF3YhQuvotFSoBCNKj3bc6hZfB3S4htpx1WEzYEU9PDS5YPwulKdl+G2Rg3Tp/mvKljLzRd8akMbxHMQPrWF3rK+mFPiUzjs/MYX60b7FGuwTBLuKtvTXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730911832; c=relaxed/simple;
	bh=fvAFf0JaFeBYm+F2wvaYY1CZI8BimVIWOliOUZ1LMAE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B7gcfvXSyL2o9we/5NFIaMTk7sdblX9JKtV1O62ZlMQjXZvGJvGDpFfv+mx2p4CJps5If5RzMd9SQxltHl0njn+80Lx52ydTJAMMlX27cXK5aUbsH3MvpEPDGi6QLjwcKrSiS0USZ/5Ugzq+pDDB6i5LYtOGofDtVnr1z39sVRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=NoRS6/0u; arc=none smtp.client-ip=74.6.131.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1730911824; bh=W0ieKc3ap2ATG+t73oWiPacelFjiXkyZM757F906zV8=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=NoRS6/0uE28oaFNbARcWCzPNI7GZhPxGQUEumYfwI3GdYqo6yuGAGlKoZ0OKBHJZjzrsVtYSsTcAlx53UvdQMVUQIz2+nfN2TOaziETP2A2GdfeVfGKOqSeSLT7a3mb6THIqyVKZotZQArL2HY6wElS5zYNGJUE2+M351M8VLA6qSCS2W6VbcUAYUXCe1/VAbvZUSvoJzAEturMhnPLo1hu6GzWNRg0/M6PUtAkU1sy9N74wFyGQXvj99RkfQKbRLf53oKnA9KH5dkABoijoFDlQxfNkHYlbFLQn80jldyw80OD16gEQG4n1y4ix6oXXVB0NzGlrbKrrUuSOpy872A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1730911824; bh=mIYBEZSWkiArJ8rQ2wF0OJDpSlEFKzgttRUT0iTH+RD=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=nIn9xTGze2TIHD6cC+rOA3lGRcwzqeJRFVoZ0Bn8g+UCinNHYWqln+plu/ku3HkGafgKv/Fzpc+gv7bVZ5aTBTpM7yaihqqjOt+Ju3mInQsCJTZyIlWIu2AaA4VQPcdUIBo5B0h7B69OjXkC7d0kka1+axUIUs+1WTMPv1mxWsTtR81u4LU5S2Z5V5olsiil9IIwzZnKynJIoJo6t1zdZJjs0W5+iU0jydAGAZfglfA45iOJXIxZDoKr0/+YWQIHK4wVT+FdRpRsbKX6bsw9qyN5AMGGSjs1V+4sgQG/LYaG3GspR3AgV9Mt2kyVKKvLLs7Lpv9+pHEmbNw2Hc6gRA==
X-YMail-OSG: Itp9kHgVM1mb1p7LBBg2BiXephJb3Ielz00JP7e28KGT05Kw.7.hRs6rEqV26Hq
 L3vssA6zBOOcHeAicnDpij40x3Uned20II46HK_mmbROrW2sgjnKtQjX9mxMOIEXfgOZNxXu5JoI
 JJsmuVnqORUUp465NbzIgTmS0P78De7YgJLM8MOh49HZ0ZhWx.kNjgUbkRLMBnblhfEAHtQJGRGl
 k4Q7YjuN.0Sw88eMMXNcXG70XGw53D.ctV42bDC6_bi5U8RAZRBiLWSlrCuiDGcCbIaxLtZ4gA.7
 llRQdKlij70oOUdOTem1YYC6.iubp.6uSmwhxHavxPXSGtnlYmb7CoDd_lWC7O9ulYI3l1b8170m
 Et8S8WNymmeA9_8aSv5MFVUdAWo9jMztPlf89Een6o_YscuwtiObSMeNIZZG.FscoMe_Jsxd6Rkh
 55QT6nLIgkDRKhgb76wLwpX29hGyNojlfFBIAyQavEw3xgMq0L6p7EpflsAtP14CECDZ0fiprxGo
 hKLEIPL51aJKEy0i6zXQXboWLBRkqzyV0s.dFLXld4CI8hxysVxB7myK6TDpoEjTrPaDCgz5NkwH
 8z2SuxW2kDDm9f_ZFvMAXrj893YvoXQlay9NxfFuVhUgGYibE8icLJPigqM0SGLA70mg2aPrBtsw
 .QiPBdIMdavndblI6aLZvkdqQHNPnZqWTfJba8KCEPeiCpOZADH6C5JGyg6EByDE3W9_KIwSMPg0
 DaxAZ0fSn4pDSasgqAce3nMPMfeBVAmKBJJWCwM.XoRRiS0JzhDxl9m4SH332Hk8aleGJe.IE8Be
 _nMsw_Ttmhzyho8IPPOmQSdK8EdfGxamepHAA95rovcjoGMn1Jy08ljjTIoYugWIvBLhTDVin2Eh
 fiAcj0uRrSkp2.CoIB6GsQUogCj1qpwKamf0a3XhK1uHGM5msH1I8xchOElubos1iSfp.eNycOTs
 EL8nxn7rwxou0ft_chooUAhmtQX.aC8c5CV5FsvU1OkP9eiJQv6aCvfX9tvAnTZ5rVlqnCQcDSWy
 iSIKZ4VFhlMfz_U0fcZgLjG3.BB1huYkxpm3AcfP8xfuMHxCYyu9iwI.xGQKCVbEeM7TE6yPJsHy
 F3D7VfqdiESlDe9Q98vNYzRHcCNhIuXCB5uBQvHmC3E9HRtUd0bOjQYq3NR5RWQQfSe5ZpOxpKR5
 WUe0j4WT01X3BZwtnUOdlxL16p619iPB7No.mC7FGJJNii8lwcUTlYXF1wOna7yOqgGomR1JbNwv
 oSRUGbaG_jDDsXbdwn2DR9X7d1vpWs1.OE6V95_DOu.SyD8rqG20mbJ59EtKOq.QCpKFCcVEIU.B
 ti3GaZ.YxqFQVym52Y9_hQd4Gu4XM_EtCl8sCQLUKfEO_.waGTYKHk_1SutQrksXquAuflquVrUZ
 AGgLLjqDv5aSQsMtELkPmKFETm1YWuBmqktilY4jwOfMF82bHZwaIxUNh4S8HdJlZVT65E_v4D23
 izxFxagQyPR95zZXAZs8toVfFb0gD5rU.JOYivWuxTGYkpqL_w2_7VUsz0JnsrZG5fREvb9QNeOV
 oOad9CEWNfZ_Rq4jcwv_3ENYj4oxFnau7wDZ3dECZPnGoo3GTVMaQm35h2h3ICIRBTeorlZ6K176
 fnn4pKiYD7EBGLNngkFE.4JVJF.g.pMPpxHgHvYeZfJoe3DWPtuEal2uDWple6ztCKq0zciMOuzX
 9xYTqozvI9yb5M9prbRtRaggntygIul5_jVLqv9x63UjOkikXsNHJvc591CIjTaDMJMdhMN111ey
 fBcaNaDDUqyDD6la5yIcDdLYehCH5BbmCVLek0jw21sEcSaaSfgUiRJsBp58aUuB4uRmdjpPYo4s
 IS8FsQHoUVCJIhNjFpbCb5HRGdY3baMOK0VYF98c8ALjhrZqEpBAPjHczBLJ1M.ZYLtBheq_L7Ul
 Et2LL8SEuItwXW0XTbM9b6r2ViW77pkA4CSdK0vKCie0OApbF1_qF6RbxS3zKiLeGd6dd3K.6V5g
 YaPg8NkJdeK_2H._GVf53BsaWzDfFXh6Rr3MRbPxKKdEfhFMJPhFUFqKupCtdVYP1HRVg9uZ0YlQ
 JxmxvXprBK4uGfzo_pffDZFm__j3.XYGaViZZ7Q8q1Ge1PmGR4L2wenbTEfmwocUse4sYTUU0DLJ
 W2AHLIkuiDKkAIhmHN1z3xZsMhMX4jG5aUI2i7N_qrKW9rww2UjCv3LkZQVdsJ4XAGiTEpc467xw
 SFhQr4ZYir_N2R_4GWlWTldhL5eRTM.Z187WeWpOoWX_UDqkC30n14jDyBiZ3
X-Sonic-MF: <dullfire@yahoo.com>
X-Sonic-ID: b8509b16-6bc8-4ea9-8dc9-b2f922c1dad1
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.bf2.yahoo.com with HTTP; Wed, 6 Nov 2024 16:50:24 +0000
Received: by hermes--production-ne1-bfc75c9cd-rq64s (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 9ac2812bfb1d027bbae0833a8fb18759;
          Wed, 06 Nov 2024 16:19:58 +0000 (UTC)
Message-ID: <973e2e20-51d9-4fe4-a361-0e07bcf95bab@yahoo.com>
Date: Wed, 6 Nov 2024 10:04:40 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Kernel panic with niu module
Content-Language: en-US
To: Thomas Gleixner <tglx@linutronix.de>, Bjorn Helgaas <helgaas@kernel.org>
Cc: davem@davemloft.net, sparclinux@vger.kernel.org, netdev@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20241104234412.GA1446170@bhelgaas> <87fro4pe6i.ffs@tglx>
From: Dullfire <dullfire@yahoo.com>
In-Reply-To: <87fro4pe6i.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.22806 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

> 7d5ec3d36123 had the mask_all() invocation _before_ setting up the the
> entries and reading back the descriptors. So that commit cannot break
> the niu device when your problem analysis is correct.

In 7d5ec3d36123 (and later) msix_mask_all() only writes to
PCI_MSIX_ENTRY_VECTOR_CTRL. I have tried all the MSIX registers, and only 
writes to PCI_MSIX_ENTRY_DATA were able to prevent a fatal trap on a read.
However the only write to PCI_MSIX_ENTRY_DATA I see is in
__pci_write_msi_msg() for 7d5ec3d36123, or pci_write_msg_msix(), in 6.11.5.

> 83dbf898a2d4 moved the mask_all() invocation after setting up MSI-X into
> the success path to handle a bonkers Marvell NVME device. That then
> matches your problem desription as the read proceeds the write.
>
> I've never heard of a similiar problem, so I'm pretty sure that's truly
> niu specific.
>
> Thanks,
>
>         tglx


Regards,
Jonathan Currier

