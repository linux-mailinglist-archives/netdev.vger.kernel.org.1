Return-Path: <netdev+bounces-171801-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF0DA4EBFC
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 19:40:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44FCE16E089
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 18:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B72FB2620FA;
	Tue,  4 Mar 2025 18:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SXHkb+uR"
X-Original-To: netdev@vger.kernel.org
Received: from beeline3.cc.itu.edu.tr (beeline3.cc.itu.edu.tr [160.75.25.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151002356DC
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 18:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=160.75.25.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741112854; cv=fail; b=ku5FHELL9X/VdC6AnbrKX31gc1HYNZgRK7/RAgid2eTJdGmCtFbae5AbnOR9tBp1fd93U5ChWDzF1r1hwVvS3w0JEoPjafscfwqlNF2jPtrf0oUH0A3CrzqUJMBcr79ape/04ZbtViFuZQvpPbEz9LjvXVDYL2/UUce9a79mT+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741112854; c=relaxed/simple;
	bh=M4g7n3ODeuEM8yGzDWn8A5b27SsQGxaNLeo5kU8HNWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r76b1Yz6B4Js3QsKANE7lMNzwy/pfZ3UIZuHu3cJSJGJ6eE+ek3U9WeSsi4UQsfVnSpwtiKBqAHwXTFx2i8PsnFOvvpRaBfe6a29RNkgbrKiwI3vLjswBWyqY7EPUob22OWV982z2+lfXxV39nq88oy7KaquvO2Ofh8N7GlY4ok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=fail (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SXHkb+uR reason="signature verification failed"; arc=none smtp.client-ip=170.10.129.124; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; arc=fail smtp.client-ip=160.75.25.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (unknown [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline3.cc.itu.edu.tr (Postfix) with ESMTPS id 4089A40CFB88
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 21:27:30 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SXHkb+uR
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6dQr44tszFwsm
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 17:31:16 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 2FEAC4273C; Tue,  4 Mar 2025 17:31:05 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SXHkb+uR
X-Envelope-From: <linux-kernel+bounces-541247-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SXHkb+uR
Received: from fgw1.itu.edu.tr (fgw1.itu.edu.tr [160.75.25.103])
	by le2 (Postfix) with ESMTP id 1999D42859
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 12:12:31 +0300 (+03)
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by fgw1.itu.edu.tr (Postfix) with SMTP id E76E13063EFC
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 12:12:30 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C783B1890775
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 09:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F19D1F0E24;
	Mon,  3 Mar 2025 09:12:20 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6172A1EF096
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 09:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740993137; cv=none; b=ATFM1Udi36g/hwL2L5AHS5Ju+lkrkPL803XVuGDYKM1W8BhpX6dalXK2RyV6/XOX6SIGW1oqcbZvFARgzsFrqBKSgcJLNZy1tL2IBwzMsy6pOVWxZYBarydve7U5VROJUOAoVOlhROrDwZi3PPzNVy9ui2U9NlyfvYM5rYVUvSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740993137; c=relaxed/simple;
	bh=geG++AXD09rWCrdjxBMlqbjlj7UuYkL2iv00OIpXTMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pP7ftx4B+7fqgehUBoDihe8anBDEfGdetEcTmqNX7coNWefa99pbTaif/CNwKkh9cp0ldJP9APCKtVuk8trEz8uyYJ4Iwnn0600dF63EAjYRYGna0qrucORrqhJE2knIcDlfODgP3JtjXfB+X5tRdaeIg0J/iC7GbXFX6je+He8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SXHkb+uR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740993134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YjVRjv35fHjv7RLlPVFkOhvXHHHtnF0rtq1Tf6M4yK4=;
	b=SXHkb+uR6dPoaye8FAbMHGiKgPSsD9M0i+mCKsnwVP23UjVM6CXx5dg5esxKRd1j2OoI3N
	qJuKSDbb7JNWthMBnOUhwlEnYk6L1nHR8jq3emOHWjQaRkIaGo7EUACk6YgAjSAWkvPvK5
	9vbNHyCrJyyluYojtNA7lKns6XgcFsk=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-505-7-InO9mrPIezYmrw-ZsBUA-1; Mon, 03 Mar 2025 04:12:13 -0500
X-MC-Unique: 7-InO9mrPIezYmrw-ZsBUA-1
X-Mimecast-MFC-AGG-ID: 7-InO9mrPIezYmrw-ZsBUA_1740993132
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5e073b9cf96so3902422a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 01:12:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740993132; x=1741597932;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YjVRjv35fHjv7RLlPVFkOhvXHHHtnF0rtq1Tf6M4yK4=;
        b=LgJHS9zQPL2EJ1aCMw/uIzpbrYdeSmNmSPF8GAQPMOe28++bpjgt7sHc46B0tbqeSA
         H5uaoFebXaR0G13DNzWPxLfJY7Nkk6d493aJFD9wseoY0ni1D+Isu/Qsm3RKFp8akWC3
         v4fWnlRCqbW/dwUq86ruafCCVX+Ra/bcl6eC4z9Wi7PKSTsAqZbHYEnlNpWXhc3pp5Ly
         XUDL294c1uowNjUhSNgCPypGzRXF7TmmFYxKrm756Z3XlWTGyFEtvrtpg4U0zEj7sVaX
         cnWfL9N6LQy5xUAYV3QGJMTf35pBIuO8E30DhvtOVBTSxB7ZXRrZEWATWhDqL2sHVgHu
         qI1g==
X-Forwarded-Encrypted: i=1; AJvYcCWZy0JSP6baycgLouqvVQevPgrxCXOAsF/t1NHQeiTSE33X+9rZs6sU91N4CYk3ponSMt/2wETEW2qFR3c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIvx92ztou+SoJzkvK2zyS44sswot+gOtOAajSKnDwQvuVRMlS
	uhPD9Xe8q9wp92mf9fPZu/zVWROt1FLP5qTDZaZUzzE5gpV11InB+dVOzRC6Gh81NlA5ixKqFK7
	cjmGs5qkRK5/jVetlLyQUmzAlhGaJJ9IyX3Mm/c4Irnl2CtvTh8F99W4tXp7lgA==
X-Gm-Gg: ASbGncvuGwjmMMST5EmAAumRiD8NDRsyVTeGbt1mROYV9lH1mKwHOMTr5NN4Uruttc6
	+EIv3w64PPM0t9WQffm0IFkaRaAmnzG3Fw9PiTUG17gbCMkNafT7pILdSjJZrYpCTL6l4tNGuGn
	6cUU3+tlZMfA45RqwkzSH3cKuepzTv9xH48+VJBxwv9Egk9dVo32zv9jCi1niA7+Uw/v3HGWjd1
	AfVrj0P6AfnrUZHrg9rk8a+sxIu9rWifAynWwdKCEgRDP/Qou06uuax9TNHUAQr6b1LpKauTI39
	/1ElNPw0+3j3HMI+YqeUwyXFrN3ifTU65YI2i5FGwYpIP4KlXpLbkdpYQ06iQYha
X-Received: by 2002:a17:907:da2:b0:abf:777d:fb7a with SMTP id a640c23a62f3a-abf777dfd1amr339932966b.46.1740993131903;
        Mon, 03 Mar 2025 01:12:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGtqN1qqtRWL94TvBz+1bpSPX8FaHG0oLP1oFMSS8+5uidcrPRyW31eyU/Z3YzkjO4tPcIZtw==
X-Received: by 2002:a17:907:da2:b0:abf:777d:fb7a with SMTP id a640c23a62f3a-abf777dfd1amr339929466b.46.1740993131263;
        Mon, 03 Mar 2025 01:12:11 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-29.retail.telecomitalia.it. [79.46.200.29])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf78023d7esm172842966b.34.2025.03.03.01.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 01:12:10 -0800 (PST)
Date: Mon, 3 Mar 2025 10:12:06 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Cindy Lu <lulu@redhat.com>, mst@redhat.com, 
	michael.christie@oracle.com, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [PATCH v7 8/8] vhost: Add a KConfig knob to enable IOCTL
 VHOST_FORK_FROM_OWNER
Message-ID: <svi5ui3ea55mor5cav7jirrttd6lkv4xkjnjj57tnjdyiwmr5c@p2hhfwuokyv5>
References: <20250302143259.1221569-1-lulu@redhat.com>
 <20250302143259.1221569-9-lulu@redhat.com>
 <CACGkMEv7WdOds0D+QtfMSW86TNMAbjcdKvO1x623sLANkE5jig@mail.gmail.com>
Precedence: bulk
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <CACGkMEv7WdOds0D+QtfMSW86TNMAbjcdKvO1x623sLANkE5jig@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6dQr44tszFwsm
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741717545.77302@Fpfh+0KGJwKaN3lifycfPQ
X-ITU-MailScanner-SpamCheck: not spam

On Mon, Mar 03, 2025 at 01:52:06PM +0800, Jason Wang wrote:
>On Sun, Mar 2, 2025 at 10:34=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote=
:
>>
>> Introduce a new config knob `CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL`,
>> to control the availability of the `VHOST_FORK_FROM_OWNER` ioctl.
>> When CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL is set to n, the ioctl
>> is disabled, and any attempt to use it will result in failure.
>>
>> Signed-off-by: Cindy Lu <lulu@redhat.com>
>> ---
>>  drivers/vhost/Kconfig | 15 +++++++++++++++
>>  drivers/vhost/vhost.c | 11 +++++++++++
>>  2 files changed, 26 insertions(+)
>>
>> diff --git a/drivers/vhost/Kconfig b/drivers/vhost/Kconfig
>> index b455d9ab6f3d..e5b9dcbf31b6 100644
>> --- a/drivers/vhost/Kconfig
>> +++ b/drivers/vhost/Kconfig
>> @@ -95,3 +95,18 @@ config VHOST_CROSS_ENDIAN_LEGACY
>>           If unsure, say "N".
>>
>>  endif
>> +
>> +config VHOST_ENABLE_FORK_OWNER_IOCTL
>> +       bool "Enable IOCTL VHOST_FORK_FROM_OWNER"
>> +       default n
>> +       help
>> +         This option enables the IOCTL VHOST_FORK_FROM_OWNER, which a=
llows
>> +         userspace applications to modify the thread mode for vhost d=
evices.
>> +
>> +          By default, `CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL` is set t=
o `n`,
>> +          meaning the ioctl is disabled and any operation using this =
ioctl
>> +          will fail.
>> +          When the configuration is enabled (y), the ioctl becomes
>> +          available, allowing users to set the mode if needed.
>> +
>> +         If unsure, say "N".
>> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>> index fb0c7fb43f78..09e5e44dc516 100644
>> --- a/drivers/vhost/vhost.c
>> +++ b/drivers/vhost/vhost.c
>> @@ -2294,6 +2294,8 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsign=
ed int ioctl, void __user *argp)
>>                 r =3D vhost_dev_set_owner(d);
>>                 goto done;
>>         }
>> +
>> +#ifdef CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL
>>         if (ioctl =3D=3D VHOST_FORK_FROM_OWNER) {
>>                 u8 inherit_owner;
>>                 /*inherit_owner can only be modified before owner is s=
et*/
>> @@ -2313,6 +2315,15 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsig=
ned int ioctl, void __user *argp)
>>                 r =3D 0;
>>                 goto done;
>>         }
>> +

nit: this empyt line is not needed

>> +#else
>> +       if (ioctl =3D=3D VHOST_FORK_FROM_OWNER) {
>> +               /* When CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL is 'n', r=
eturn error */
>> +               r =3D -ENOTTY;
>> +               goto done;
>> +       }
>> +#endif
>> +
>>         /* You must be the owner to do anything else */
>>         r =3D vhost_dev_check_owner(d);
>>         if (r)
>> --
>> 2.45.0
>
>Do we need to change the default value of the inhert_owner? For example:
>
>#ifdef CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL
>inherit_owner =3D false;
>#else
>inherit_onwer =3D true;
>#endif
>
>?

I'm not sure about this honestly, the user space has no way to figure=20
out the default value and still has to do the IOCTL.
So IMHO better to have a default value that is independent of the kernel=20
configuration and consistent with the current behavior.

Thanks,
Stefano

>
>Other patches look good to me.
>
>Thanks
>
>>
>



