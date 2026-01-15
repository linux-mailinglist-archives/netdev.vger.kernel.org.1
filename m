Return-Path: <netdev+bounces-250013-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E0FD22AAB
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 07:54:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 461933064FD7
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 06:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F8B30C342;
	Thu, 15 Jan 2026 06:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gZ98keip"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DA530BB96
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 06:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768459937; cv=none; b=chimHw2lUC7VhRGznu8YUEslKlLMnhbULBN3eLqIDTn3P9RbpXqq5hNh30e2BLHkrS+YGneU1md236C1rG9ULH14qowlR/6rolngv5ASB3odGDxtFDnWoJdqv+aooostHLqFXnXK+g4lQuLrUGeNK5s+jxGvplwsomwHBTimZiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768459937; c=relaxed/simple;
	bh=R0yXlN5cNUL+m6AfvqZD1sykh2ssXljuJScK7r4+9ig=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=mTNevzpIjZ+TcxNkflYxqNgfqoKB88RnZ40eK5mX5rnFDJ4wqcFgBh4q0bb0vR9jG/5lIsNIMzXUQYILVcm6WOQ8cZ5+YhxWL1EyMZre3Ng7kBQqKi3DMDDiUlM8ufBhOoDDfr3SaPnm9iG8MwFfrMWSuK5qatMs3IQFwJodX+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gZ98keip; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47ee07570deso3798155e9.1
        for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 22:52:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768459931; x=1769064731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=E6tehYjlJFO44NPgy9nS1hqsEl0aIZAWL8hqwUtyZRU=;
        b=gZ98keipeEbG//oq2ra0xQJqLat6royIqiwI5UejKoQpOJvNEWfpKNeLT5OsJxKvDV
         MrU5OskFrTgA0IcKD6UWJE6ZCCoX3jCs6+EiBbmzJ/NdI01HMENGtcVD3l0tKLEnGTWR
         0JcUutiqgv/av73lm1Y6qXTfBMdFuZWQYlD1E/JNNFWLUpJ7OrbN6DThB66sF+xQf3sT
         5wGQTdIwIYK08iwMJTQ2Z5e9MXbZNtFV275APHSXzMF4gbzwt7q4POLzVfNyZCPISJs/
         qjfd+anSIWZ5510W//h7t59KIgVQmMXBR0Pt20Imq1AvbLlsDaqagfHylj3rSXQIRgLr
         eqVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768459931; x=1769064731;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E6tehYjlJFO44NPgy9nS1hqsEl0aIZAWL8hqwUtyZRU=;
        b=vqowdNTIJOZ5HjoTOJAmuhsu/mLT7suVA77z2XlC64ukyELU25zO0+UypUJqSPL4f1
         FJ6jyYaOvtkYcEBNWyGd064t8rOvU/cRyMv6vHQmcrnsGglGT7bPpFC7HXc4sk/7ztBd
         3WdbjiJ5ddjHBhB+HldC3Ug3U5SNXpe09SCNTEQmRGq+QOXHdAwdeiluKfTbXnvK63as
         k1+V1qsyDak3it6Cwh9y1CjucFQUw1tCu5bzcDU+NYf2BKtkEx6+tmj0Oln/eoi8b5hl
         JhSod4QN+ilV/JrQu13c8ajCQV/cTKNr8U8t9+TQVKiZDMMzE1Ifv3lwGFq4EL523NbQ
         zBhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVshwlHoGFUjlmjXq8wenGH+SSK6SqT9gGVIfhYfi3H/Wrutsu4Agimk5U2ih44+R6DoM1yzZc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyczrtCNvsIT6wKKMqYHHxRexD91UxrmHP6GqL1gA6wY39MelJV
	8dAG8P1pE8eZ5L7vYNsdnJ2cr5U5ji47AsG97j/djaJ8B1/AEwTqwd/wbD6bSA==
X-Gm-Gg: AY/fxX6rfWWCDTZpK0oLGMUELyu0AEVifGZt2n9Q/k+zAGEdLAkVD4sFdvi40C2H/ML
	fUoCfPKG6TLbwI/dvCR4mvSFCefZaV6RUv1kXt0kADFFxCGvCyDUc10AVshDW0JbXQDnYTkTEVS
	9cdb1BF1rdh+bb/XOJyCP0s6efbavcenRXIvQHJ3tKuuyOc+KB6KD4F1lrQT0yyqAYItcSBVQKM
	O4qpF6GWOclnzl8OB26zTBZysS12kHnMPqfmcw6DtDACWyIRVXtVHKMuGNle3DHVW1gRVnaEBhU
	5U6fxxNE+1pSRoRvK6LzonDOZmCtWc6Ny82xeqog7ddXXR6Zaf2VjblW54lyqDjDn9c5tskmjZr
	s/PNM5A4aTqmjyNGngzqNe84O3xtf0+Ho1EudyiiLCjV93FvmBtAIAi5Kk+ZYIIs0Gorlnszaqd
	mqAtLJ/fDdxeQcNpQtfkjzNegv/6U/QVYGiA==
X-Received: by 2002:a05:600c:83c3:b0:477:8a2a:1244 with SMTP id 5b1f17b1804b1-47ee32fcf0amr50194125e9.11.1768459931267;
        Wed, 14 Jan 2026 22:52:11 -0800 (PST)
Received: from ehlo.thunderbird.net ([80.244.29.171])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-434af653745sm3912300f8f.12.2026.01.14.22.52.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jan 2026 22:52:10 -0800 (PST)
Date: Thu, 15 Jan 2026 08:52:08 +0200
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>, Slark Xiao <slark_xiao@163.com>
CC: Johannes Berg <johannes@sipsolutions.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>,
 "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 Daniele Palmas <dnlplm@gmail.com>
Subject: =?US-ASCII?Q?Re=3A_=5BRFC_PATCH_v5_2/7=5D_net=3A_wwan=3A_core=3A?=
 =?US-ASCII?Q?_explicit_WWAN_device_reference_counting?=
User-Agent: K-9 Mail for Android
In-Reply-To: <CAFEp6-3n=125v7RDbbJaT2XPyt+adGfgY-pgXguymYVy+oxuaw@mail.gmail.com>
References: <20260109010909.4216-1-ryazanov.s.a@gmail.com> <20260109010909.4216-3-ryazanov.s.a@gmail.com> <CAFEp6-3n=125v7RDbbJaT2XPyt+adGfgY-pgXguymYVy+oxuaw@mail.gmail.com>
Message-ID: <F9203EE2-8486-4CAD-8DD0-36971F3E9DA0@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On January 14, 2026 11:31:45 PM, Loic Poulain <loic=2Epoulain@oss=2Equalcom=
m=2Ecom> wrote:
>On Fri, Jan 9, 2026 at 2:09=E2=80=AFAM Sergey Ryazanov <ryazanov=2Es=2Ea@=
gmail=2Ecom> wrote:
>>
>> We need information about existing WWAN device children since we remove
>> the device after removing the last child=2E Previously, we tracked user=
s
>> implicitly by checking whether ops was registered and existence of a
>> child device of the wwan_class class=2E Upcoming GNSS (NMEA) port type
>> support breaks this approach by introducing a child device of the
>> gnss_class class=2E
>>
>> And a modem driver can easily trigger a kernel Oops by removing regular
>> (e=2Eg=2E, MBIM, AT) ports first and then removing a GNSS port=2E The W=
WAN
>> device will be unregistered on removal of a last regular WWAN port=2E A=
nd
>> subsequent GNSS port removal will cause NULL pointer dereference in
>> simple_recursive_removal()=2E
>>
>> In order to support ports of classes other than wwan_class, switch to
>> explicit references counting=2E Introduce a dedicated counter to the WW=
AN
>> device struct, increment it on every wwan_create_dev() call, decrement
>> on wwan_remove_dev(), and actually unregister the WWAN device when ther=
e
>> are no more references=2E
>>
>> Run tested with wwan_hwsim with NMEA support patches applied and
>> different port removing sequences=2E
>>
>> Reported-by: Daniele Palmas <dnlplm@gmail=2Ecom>
>> Closes: https://lore=2Ekernel=2Eorg/netdev/CAGRyCJE28yf-rrfkFbzu44ygLEv=
oUM7fecK1vnrghjG_e9UaRA@mail=2Egmail=2Ecom/
>> Suggested-by: Loic Poulain <loic=2Epoulain@oss=2Equalcomm=2Ecom>
>> Signed-off-by: Sergey Ryazanov <ryazanov=2Es=2Ea@gmail=2Ecom>
>> ---
>> Changes:
>> * RFCv2->RFCv5: new patch to address modem disconnection / system
>>   shutdown issues
>> ---
>>  drivers/net/wwan/wwan_core=2Ec | 37 ++++++++++++++++++----------------=
--
>>  1 file changed, 18 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/net/wwan/wwan_core=2Ec b/drivers/net/wwan/wwan_cor=
e=2Ec
>> index ade8bbffc93e=2E=2E33f7a140fba9 100644
>> --- a/drivers/net/wwan/wwan_core=2Ec
>> +++ b/drivers/net/wwan/wwan_core=2Ec
>> @@ -42,6 +42,9 @@ static struct dentry *wwan_debugfs_dir;
>>   * struct wwan_device - The structure that defines a WWAN device
>>   *
>>   * @id: WWAN device unique ID=2E
>> + * @refcount: Reference count of this WWAN device=2E When this refcoun=
t reaches
>> + * zero, the device is deleted=2E NB: access is protected by global
>> + * wwan_register_lock mutex=2E
>>   * @dev: Underlying device=2E
>>   * @ops: wwan device ops
>>   * @ops_ctxt: context to pass to ops
>> @@ -49,6 +52,7 @@ static struct dentry *wwan_debugfs_dir;
>>   */
>>  struct wwan_device {
>>         unsigned int id;
>> +       int refcount;
>>         struct device dev;
>>         const struct wwan_ops *ops;
>>         void *ops_ctxt;
>> @@ -222,8 +226,10 @@ static struct wwan_device *wwan_create_dev(struct =
device *parent)
>>
>>         /* If wwandev already exists, return it */
>>         wwandev =3D wwan_dev_get_by_parent(parent);
>> -       if (!IS_ERR(wwandev))
>> +       if (!IS_ERR(wwandev)) {
>> +               wwandev->refcount++;
>>                 goto done_unlock;
>> +       }
>>
>>         id =3D ida_alloc(&wwan_dev_ids, GFP_KERNEL);
>>         if (id < 0) {
>> @@ -242,6 +248,7 @@ static struct wwan_device *wwan_create_dev(struct d=
evice *parent)
>>         wwandev->dev=2Eclass =3D &wwan_class;
>>         wwandev->dev=2Etype =3D &wwan_dev_type;
>>         wwandev->id =3D id;
>> +       wwandev->refcount =3D 1;
>>         dev_set_name(&wwandev->dev, "wwan%d", wwandev->id);
>>
>>         err =3D device_register(&wwandev->dev);
>> @@ -263,30 +270,21 @@ static struct wwan_device *wwan_create_dev(struct=
 device *parent)
>>         return wwandev;
>>  }
>>
>> -static int is_wwan_child(struct device *dev, void *data)
>> -{
>> -       return dev->class =3D=3D &wwan_class;
>> -}
>> -
>>  static void wwan_remove_dev(struct wwan_device *wwandev)
>>  {
>> -       int ret;
>> -
>>         /* Prevent concurrent picking from wwan_create_dev */
>>         mutex_lock(&wwan_register_lock);
>
>FYI, you can use guarded mutex:
>guard(mutex)(&wwan_register_lock);
>This ensures the lock is 'automatically' released when leaving the
>scope/function, and would save the below goto/out_unlock=2E

Sounds curious=2E Will keep in my mind for a future development=2E I would=
 rather keep this patch as simple and clear as possible=2E

>> -       /* WWAN device is created and registered (get+add) along with i=
ts first
>> -        * child port, and subsequent port registrations only grab a re=
ference
>> -        * (get)=2E The WWAN device must then be unregistered (del+put)=
 along with
>> -        * its last port, and reference simply dropped (put) otherwise=
=2E In the
>> -        * same fashion, we must not unregister it when the ops are sti=
ll there=2E
>> -        */
>> -       if (wwandev->ops)
>> -               ret =3D 1;
>> -       else
>> -               ret =3D device_for_each_child(&wwandev->dev, NULL, is_w=
wan_child);
>> +       if (--wwandev->refcount <=3D 0) {
>> +               struct device *child =3D device_find_any_child(&wwandev=
->dev);
>> +
>> +               if (WARN_ON(wwandev->ops))      /* Paranoid */
>
>You may keep a reference to child (if existing)
>
>> +                       goto out_unlock;
>> +               if (WARN_ON(child)) {           /* Paranoid */
>> +                       put_device(child);
>> +                       goto out_unlock;
>> +               }
>
>Maybe you can simplify that with:
>```
>struct device *child =3D device_find_any_child(&wwandev->dev);
>put_device(child) /* NULL param is ok */
>if (WARN_ON(child || wwandev->ops))
>    return; /* or goto */
>```

Good point=2E

Slark, could you adjust this in your future submission or do you want me t=
o send another RFC series?

>>
>> -       if (!ret) {
>>  #ifdef CONFIG_WWAN_DEBUGFS
>>                 debugfs_remove_recursive(wwandev->debugfs_dir);
>>  #endif
>> @@ -295,6 +293,7 @@ static void wwan_remove_dev(struct wwan_device *wwa=
ndev)
>>                 put_device(&wwandev->dev);
>>         }
>>
>> +out_unlock:
>>         mutex_unlock(&wwan_register_lock);
>>  }

--
Sergey

Hi Loic,

