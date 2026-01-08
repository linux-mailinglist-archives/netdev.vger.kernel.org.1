Return-Path: <netdev+bounces-248073-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 78FAFD02E13
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 14:10:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 27A623008F47
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 13:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B33964E379B;
	Thu,  8 Jan 2026 13:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DKct2XYP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7E64E378D
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 13:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767877306; cv=none; b=ecXCZIBOLCPdLT6+5YmZfoZ4kW7TW6up3MlzA10UgGEyImkrKlW4Nvny7iRyRQscjAHpkf64iJg3Ss0dr1e3qMgT51nA5I1iKZN7sff7KMmk7BRzp1dGE+FWfkfgidv48/868BfgDz5XmQi5axgRSLNHOo5PdcIvLoQZrd4Pom8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767877306; c=relaxed/simple;
	bh=uL4Yk2KF5OidX6ayGaC4GGOSB1cQ6NDOu3/ycs7ERvo=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=JI13eoOwLv9Y4ssK8YdPjD7KRCg6m9TfFmDCcs9mCRGEwaJdI9AS1tNFGbgqoNuo4aGd9nMC7fVJhjyobKxWsrSTdjqbucfIJUtaY7y2PR0wXoq06UwJ+ZWD6EyXa7Z67nDa3yXG9lDMHiHLVmvfNmQJ7a2cpJ6f1zrEA5eeTIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DKct2XYP; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47755de027eso18884495e9.0
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 05:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767877303; x=1768482103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dDV2vVxCeWUjLMPvP38kXloBTtJItn+7SfPcpEvkJqg=;
        b=DKct2XYPw92HQlgjXFS2S3uvUZ+u1anXcGe/BuhiVoJi98Dxp4eXVwT+vAVKusv8Mq
         NF6aJE6ug/xYotmyRiUBbvi1/WZ7k56mjKmMxGE8neJouad0kf8b/UsHDZG1hvV7p3yC
         KHhzGno8cbB24rdJKfKWmakdVBC7fkNTBEJoEFXZefBs5JUJuMUkRW7OLnlV8SoOmQav
         u/YcftoJMlH5cLPH0jVQwvUKF1dxD1khc8EotLC+GS8Z9XB75nsI+PyucrvTnozWbjUx
         M53AigdL5YmIENQi3PwcyCfJkXjr3es+65p85iWLXC543GRweNf4LcYXMpWj6W2d3qZ4
         33oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767877303; x=1768482103;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dDV2vVxCeWUjLMPvP38kXloBTtJItn+7SfPcpEvkJqg=;
        b=NDXpHJ4VJMGEazkhmnfDWhPrTdxOfgB3u0iD6X65Hyk8IDtxMYWuH69LNfh7UYGIV5
         WJMF5pV8fEFSAWf8qkPfGjXAZQO6UQOTdk3ptY4pUcZrv5MRSDPpzNiToApZEcnLhw+h
         AQtkYN8ADKYF0ha9YIMOUo3eYrCs1MnmEh7wd958di2axMPJI222RoqW64ebIcHcAQfS
         JZ5RYq/0H+6jBPDaqq2xaD2k0gdqe0b8chOs0X6JgqK7aP2TcYZX/hmYbtHoBUyELF9N
         S8DqEtPXxoxO5F1G8xKWLzDWuKI2xfjvAOiGoamQ1A+NGHqGJW0Xz+5wFxFXwKX0eYDq
         WYOg==
X-Forwarded-Encrypted: i=1; AJvYcCXYfquIkoPXslwVGpOVkBdwQxkI3CXQ5O9Ca7LEICxbTilLQ/Q2cPRuNE2f9wb7OSxdKjMSFPs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8bc7l5ODbWD7qHatre668VE1oZoAKndPu1I5uR3Wg8jQPjuvd
	gx3bl1BVHW1gVpy0B4vXKGS09kecSi1IkvnCDFOoWTDaGdUkCx8UK1+a
X-Gm-Gg: AY/fxX7G67t4bvj+1bHdNG53lLnBCQb+GCzkaiUl9MG5LstZN5Nc9U/jBxd6XhPb1KT
	pKh98huG6myNKSub7Kl8qD3HDeeZVD5T1sZn0yiJM5qb/5H5UpbfVBUk1T45XUae0VS2zaFU6lm
	z97wn2nq5DAAjAmt8B7KJFrJfc0E98YKZscmdriEJ0io/0w0Z6aHtpQF8DKn0remm1NcX8xJZnq
	pjy8PEFXojtn/JAzF86ns6wKTRPBHX5TW2LqMVPC4RX81ebdY2smYyrCG6GAbLQJGtvTR0XWVDf
	mZ4Hsm6pGVVq51xX+semQKamRCbW6+MCp1VOGltSEjhuLm4eQP+/7SGsyp//i+PhZHGmK0Lyvhf
	N5h1md9efJ59QLW0ZooErkMMG4bj+ffK+upPrlS85/Ex6MPpJkhkD2HEzvfuO6Q6lPvxyTUvMss
	PmqERqONVx6EnOURBRi9d2CRg=
X-Google-Smtp-Source: AGHT+IEyexs5/SGl+AmwCJWeo/F0air/BsllKdBeTFxLa6gffh7+fXor9MFLjJSeuPURGdQdWV/6rQ==
X-Received: by 2002:a05:600c:8b2c:b0:477:7f4a:44b0 with SMTP id 5b1f17b1804b1-47d84b3ea06mr69732735e9.33.1767877302796;
        Thu, 08 Jan 2026 05:01:42 -0800 (PST)
Received: from ehlo.thunderbird.net ([80.244.29.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f703a8csm150756875e9.13.2026.01.08.05.01.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jan 2026 05:01:41 -0800 (PST)
Date: Thu, 08 Jan 2026 15:01:37 +0200
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
CC: Johannes Berg <johannes@sipsolutions.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>,
 "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 Daniele Palmas <dnlplm@gmail.com>
Subject: =?US-ASCII?Q?Re=3A_=5BRFC_PATCH_1/1=5D_net=3A_wwan=3A_core=3A_e?=
 =?US-ASCII?Q?xplicit_WWAN_device_reference_counting?=
User-Agent: K-9 Mail for Android
In-Reply-To: <CAFEp6-17zHKA+88FfTqUKV44O18sg7Ow2HAt05ucucaXjXbSKA@mail.gmail.com>
References: <63fddbfb.60e7.19b975c40ea.Coremail.slark_xiao@163.com> <20260108020518.27086-1-ryazanov.s.a@gmail.com> <20260108020518.27086-2-ryazanov.s.a@gmail.com> <CAFEp6-17zHKA+88FfTqUKV44O18sg7Ow2HAt05ucucaXjXbSKA@mail.gmail.com>
Message-ID: <62406CC3-02F6-4D9D-9A0B-63C07B162AA6@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On January 8, 2026 10:59:10 AM, Loic Poulain <loic=2Epoulain@oss=2Equalcomm=
=2Ecom> wrote:
>On Thu, Jan 8, 2026 at 3:05=E2=80=AFAM Sergey Ryazanov <ryazanov=2Es=2Ea@=
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
>>  drivers/net/wwan/wwan_core=2Ec | 29 +++++++++--------------------
>>  1 file changed, 9 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/net/wwan/wwan_core=2Ec b/drivers/net/wwan/wwan_cor=
e=2Ec
>> index ade8bbffc93e=2E=2Ed24f7b2b435b 100644
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
>> +       unsigned int refcount;
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
>> @@ -263,30 +270,12 @@ static struct wwan_device *wwan_create_dev(struct=
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
>>
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
>> -
>> -       if (!ret) {
>> +       if (--wwandev->refcount =3D=3D 0) {
>
>Looks good to me, though I=E2=80=99m not sure why this wasn=E2=80=99t the=
 initial
>solution=2E I=E2=80=99d suggest adding a paranoid WARN here, just in the
>unlikely case there are still ops or wwan children attached=2E

Good point=2E Will put BUG_ON for both: ops and *any* child existence=2E

--
Sergey

Hi Loic

