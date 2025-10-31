Return-Path: <netdev+bounces-234675-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A82C25F2D
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 17:00:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 79A794F6ED2
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 15:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1DE2EC561;
	Fri, 31 Oct 2025 15:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FygITviR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060732EBBBC
	for <netdev@vger.kernel.org>; Fri, 31 Oct 2025 15:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761926170; cv=none; b=Vj4DHCqBvbKTy8Z4yEfXxCOiAd2xCwOPs3crJA96d94kUmOJaR/PlGm/mw0ExD3OG2tt81SPlxdmkrDAzW505weUJctyjCzXwNHoW/WoLdbXeNHWysEUW2gzNcwzNwQIiVspQ8Q47UdF3dNhe2IftxFVU6H6zxeFvR6+xdfGfig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761926170; c=relaxed/simple;
	bh=z5xO/m0rwDTo6NQigKOGrGGFnxACU0bxzZRjptLe6+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eE6NYU+Ov3Nlc5dokx2ajLKjRHxAt44Y9RAJE7fyOcLN4VHw3Y0lE1pl3ohDP0NaF7psNIPqlhAs6F/21JWZdDu2+AqifUM3BTQ1tn9n1Is5/aso4XOjz/hUEtaS9qJlZi6HCAQFGShigy747g1dP+P4Lt+r4isb530//gyajig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FygITviR; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-295291fdde4so1313165ad.2
        for <netdev@vger.kernel.org>; Fri, 31 Oct 2025 08:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761926168; x=1762530968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o/TEbnCurHUc/3b7e5l2i0tBuf8bGlvt/g1WNhbQ+jQ=;
        b=FygITviRWtTYXvpapv6V14AZIOOpjUOsSTTD0kjx9GCiJQdtx2/5VZYVk2z4tZoFG9
         Hsy8/lKKPsonP/gLO8JS/E9rgtGgrbQUQzmHznUi3bg63FrXmAy6jm39SCsCDEHJv6tV
         lU4LW3iUIQSSI0ESgxwQooY3dZKSSwIQQC/eQ3YroUxBbbzXR2rcIxWzJOdczdagF/BW
         3fZlfOEx7/zZpm9CmtseKVRoP5djW2/3Jjw0vzAn82794b4mXCXOZ3pR7r/9/NcLV2ZA
         XhuQRDATlPsZ3G0vBbqlGSvsIaOW8Qi2OgzvaPe/UY7MPuhm9adlwDNcRoAkjtQ8lIMI
         Cxig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761926168; x=1762530968;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o/TEbnCurHUc/3b7e5l2i0tBuf8bGlvt/g1WNhbQ+jQ=;
        b=E/zfBsMNyIq10maJhR0etVQXS6pM2Js8Ue2N5l9DBYVMYdKI/uK1ch+udfJMty3RKp
         5TFY1FKvI/4GJwZH61tuyxA5ZKwyDR/Ih4rrTMieLFBUu4KOKNUzwtUe++NU96Ka0eKi
         i3hiO9+Rau9+UQ8ndOhTyybhmY7vl+HTk+JclJrOC3icIkA+L+84NMbOw1Y02cMlx9ts
         zWgL1yAKECcbzbL9839kNcYOoryT5qlZQD4bt1x1U98LNxGYG95PYFkcWJVYae2rUJRB
         x5cxt2k3REXibQJ+s0cxIBBYx85bMXo2MnCa/Y6WHS8jFWIHa30iS833cwgYoOr4kZC1
         3lUg==
X-Forwarded-Encrypted: i=1; AJvYcCVAvOhIB2ITzhHQfq605GUrDHzNJjxWFrq3WW3OSrK3wM8Ef2ZGq6A/HTecMaEbi6pM0Gbvok4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoY+VMnHtK/ZWID68bcYpoZ0sP7jlPixqKYws/KPGsunSH/vev
	ZqIgMIN5e63XVH9Z8FyZkou3brvCHfa/N5bljDtIi0dKYOJcqG6Tjn/8
X-Gm-Gg: ASbGncvyi+651KL/3yp3lvrq1AhYApxf7DiNZB3HTwVpCszAfoXK2/O4RkNZrHPIppx
	BFcXhHRz8PSPtfAljktri+56feheZp9NJxEbWM1Vsq5SlSDLTm4xYazJitw5aGILrAojOFBatKn
	9ZEDXjcVgUZHGUKPggPiInbVaIgZ5L4C07E9PW9C5nqeEKHjaInqsiYAEIzTtTMQqUByH/2zU49
	EwhWmPlMp+L7cuIBYYY6/yrJbFsDe43DRM8rmPfoJOPj+Wov+/fWrtH0bnhLj2YEkFgFlg6lEs7
	tw4BKFjRiwqFta2PtqhHdMWBApWnzX0pFTc0A134KuSJliz+Rb6st59Ot8+yg0xixlAeNaVMine
	wdODCXPOdHoEReG24KqZMtNfWTcLY0B8FXujXalJWe/8hDznXFFOLYDo+6V8HBCJ1QaEPt5X4wQ
	EgZ3UDoRusVMRQpNE0GhdzWMfIbeNgUzjBvR+AVGGDSvttHl4xChRL
X-Google-Smtp-Source: AGHT+IGMvOOUVVK2H3mZ+2QgikwPdprzOKFpvLw8gb/AJwO95Vom6hBHxKSXXhgqcHK2Bk5A3VmauQ==
X-Received: by 2002:a17:902:f395:b0:26c:3c15:f780 with SMTP id d9443c01a7336-2951a49dd38mr19515115ad.8.1761926167936;
        Fri, 31 Oct 2025 08:56:07 -0700 (PDT)
Received: from ranganath.. ([2406:7400:10c:5702:8dcc:c993:b9bb:4994])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29526871b31sm28664475ad.8.2025.10.31.08.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 08:56:07 -0700 (PDT)
From: Ranganath V N <vnranganath.20@gmail.com>
To: edumazet@google.com
Cc: davem@davemloft.net,
	david.hunter.linux@gmail.com,
	horms@kernel.org,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	khalid@kernel.org,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	skhan@linuxfoundation.org,
	syzbot+0c85cae3350b7d486aee@syzkaller.appspotmail.com,
	vnranganath.20@gmail.com,
	xiyou.wangcong@gmail.com
Subject: Re: [PATCH] net: sched: act_ife: initialize struct tc_ife to fix KMSAN kernel-infoleak
Date: Fri, 31 Oct 2025 21:25:58 +0530
Message-ID: <20251031155558.449699-1-vnranganath.20@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CANn89iJL3upMfHB+DsuS8Ux06fM36dbHeaU5xof5-T+Fe80tFg@mail.gmail.com>
References: <CANn89iJL3upMfHB+DsuS8Ux06fM36dbHeaU5xof5-T+Fe80tFg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

>> Fix a KMSAN kernel-infoleak detected  by the syzbot .
>>
>> [net?] KMSAN: kernel-infoleak in __skb_datagram_iter
>>
>> In tcf_ife_dump(), the variable 'opt' was partially initialized using a
>> designatied initializer. While the padding bytes are reamined
>> uninitialized. nla_put() copies the entire structure into a
>> netlink message, these uninitialized bytes leaked to userspace.
>>
>> Initialize the structure with memset before assigning its fields
>> to ensure all members and padding are cleared prior to beign copied.
>>
>> This change silences the KMSAN report and prevents potential information
>> leaks from the kernel memory.
>>
>> This fix has been tested and validated by syzbot. This patch closes the
>> bug reported at the following syzkaller link and ensures no infoleak.
>>
>> Reported-by: syzbot+0c85cae3350b7d486aee@syzkaller.appspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?extid=0c85cae3350b7d486aee
>> Tested-by: syzbot+0c85cae3350b7d486aee@syzkaller.appspotmail.com
>> Fixes: ef6980b6becb ("introduce IFE action")
>> Signed-off-by: Ranganath V N <vnranganath.20@gmail.com>
>> ---
>> Fix a KMSAN kernel-infoleak detected  by the syzbot .
>>
>> [net?] KMSAN: kernel-infoleak in __skb_datagram_iter
>>
>> In tcf_ife_dump(), the variable 'opt' was partially initialized using a
>> designatied initializer. While the padding bytes are reamined
>> uninitialized. nla_put() copies the entire structure into a
>> netlink message, these uninitialized bytes leaked to userspace.
>>
>> Initialize the structure with memset before assigning its fields
>> to ensure all members and padding are cleared prior to beign copied.
>> ---
>>  net/sched/act_ife.c | 13 ++++++++-----
>>  1 file changed, 8 insertions(+), 5 deletions(-)
>>
>> diff --git a/net/sched/act_ife.c b/net/sched/act_ife.c
>> index 107c6d83dc5c..608ef6cc2224 100644
>> --- a/net/sched/act_ife.c
>> +++ b/net/sched/act_ife.c
>> @@ -644,13 +644,16 @@ static int tcf_ife_dump(struct sk_buff *skb, struct tc_action *a, int bind,
>>         unsigned char *b = skb_tail_pointer(skb);
>>         struct tcf_ife_info *ife = to_ife(a);
>>         struct tcf_ife_params *p;
>> -       struct tc_ife opt = {
>> -               .index = ife->tcf_index,
>> -               .refcnt = refcount_read(&ife->tcf_refcnt) - ref,
>> -               .bindcnt = atomic_read(&ife->tcf_bindcnt) - bind,
>> -       };
>> +       struct tc_ife opt;
>>         struct tcf_t t;
>>
>> +       memset(&opt, 0, sizeof(opt));
>> +       memset(&t, 0, sizeof(t));
>
>Why is the second memset() needed ? Please do not add unrelated changes.
>
>Also I would also fix tcf_connmark_dump()

Hi Eric,
Do you want me fix tcf_connmark_dump() in this patch or new?

Regards,
Ranganath

