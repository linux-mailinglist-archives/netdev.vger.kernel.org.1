Return-Path: <netdev+bounces-174710-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C2BEA5FFED
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 19:49:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3C173A6A05
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 18:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF0F1F03C2;
	Thu, 13 Mar 2025 18:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OsR2FsKb"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2070F1531C5
	for <netdev@vger.kernel.org>; Thu, 13 Mar 2025 18:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741891750; cv=none; b=UN/zIKyPjPhOTCeQGeuNKaqyIWaV/kWEPmj+a0ZunqXuKMZQY6SH5c74cm3mEE070CgqMiZjqfBcJ9PgvCQYx26UNRn6HfApAB9a1qRpHkeu9FyY1EQ4Qds7uHck9Zc+c+1Zt7Zg4rYjdnVtgHwFrKKDqczUMR/9JFj9cvwHXRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741891750; c=relaxed/simple;
	bh=vGaveTKeKgCxAmnC9EQ4sn2CMv/qBrgjuvuYfa1RVkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jg086jadta+51sb/1I4FWneQFcMyB94ATODwU/c4H7dKrRrKNcLTnjk1U/GCtW9L0P+GQIjFDmVyCElwqYKWCNawR25pGriu614SumYdBE7KhY4+xiYUifj4Xfaj0mEz3jMvoZhI2l46tpQEUtohMWkYP2J6wR4hHovJp7zKZ2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OsR2FsKb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741891748;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D9aZe+iaudDpMDo0mPe7/sxlSIcMfnUdZ2EM2OaZ1sk=;
	b=OsR2FsKbcKOIQ2NO4ex2AUaP5RsapStbiaazWEwSaJI3x0ur/4z7BSVRJy4rBGzCH0efS8
	1snKELsbtOIENb1Y8N+LZNabBmNlKE/rr1rAK4CKRTF3UpzOGvTeApt9FD5H+OTL1WSEqJ
	qRjLccObvjzXHRfrobdaIctnzZokzug=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-326-if5mwhhENNWG6gjMhdzWBA-1; Thu, 13 Mar 2025 14:49:04 -0400
X-MC-Unique: if5mwhhENNWG6gjMhdzWBA-1
X-Mimecast-MFC-AGG-ID: if5mwhhENNWG6gjMhdzWBA_1741891738
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-39130f02631so650919f8f.2
        for <netdev@vger.kernel.org>; Thu, 13 Mar 2025 11:49:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741891738; x=1742496538;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D9aZe+iaudDpMDo0mPe7/sxlSIcMfnUdZ2EM2OaZ1sk=;
        b=KuviCuAPP3QEVB7DOZQiLh8CljTbCGAxmAMPOCOmoyIBy7942+pBz3a4F6yID9j30y
         IFimIR1Zaiy5UQTlD3eXO1VXCkMO+E4NBhC0VALa7DwuEb5pljIoPRePu52p6Z4k1uwF
         iGn+8c8yKSQw3CfWNLdN5QBq6prFPrXPyrOr+7ElvfaO6PGoyqafXdd5Y2yZER/N2je4
         2491m7zWbvn6RBA0rt2yq3H6tuvL2d9wOEr89XVsvyRk3GlXhMXCeohvPG2CeXWDGQ/V
         5gCjSiKdvh/LhpRgrRdlUpU14aydOz+G1xa5OJHAkQjhiv620R+VuR8578dTTvWOdR/N
         uVSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfa9Gf4dZvmwKnPlPEPqD7fYV4eNCn1Q6lsUKnETO+s6zK9yRemP5goa6hudQZjBsKkbjiDho=@vger.kernel.org
X-Gm-Message-State: AOJu0YypCt7GeNmchQ4pG5MLCfcgYRToyFy2lcGGrD4I8RZ3BQvNiwKf
	j/gNHbH1nqUl79kbAIMkQ9oLvQNMkK5nydYxnyVNQ6oVvOeEQ2WGYqNpr2PgcyNJfSk+mPNOlzf
	Wha5HbBjxZY+4/8rbv6C4894xb2WLVBrODdYT2nIPwiPu+tw+IAdjmA==
X-Gm-Gg: ASbGncu2YaqsR43QeIeJ2FE3/ilUBDVzYftgLxm4juVsbrt4RQ2DFMjqXB6unuSevzx
	0IfJ6z5wQyLflxpEvHihXomD8KE7fQSqO/ZxHXzJLXeACqunGUD2sYy7pvL0NUd+4YB/iKkqW88
	KudveZIeg4Mh4TCNLIm6OLRo7JpOA00B8LuhLPEKRKTA/SedNrohDsh6mJO70qGRFqxYkuAn8kL
	WygoGVrGzQzkIySuEQZGmo28S49Nd2MGB6Ok34GquwGMpB/z5DTfQkdlG0oqtgiVE7M4h/GIZ9k
	1Q+WovvPaQ==
X-Received: by 2002:a05:6000:178b:b0:391:c78:8895 with SMTP id ffacd0b85a97d-396eb8c4c24mr52378f8f.50.1741891738537;
        Thu, 13 Mar 2025 11:48:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFiTFy8KH7Dv3eYYsTrcbBbEoTNapIuB3vn5zSLGQGf/vt0sASshS9p0fTfDPLfBsj9yQoDA==
X-Received: by 2002:a05:6000:178b:b0:391:c78:8895 with SMTP id ffacd0b85a97d-396eb8c4c24mr52362f8f.50.1741891738209;
        Thu, 13 Mar 2025 11:48:58 -0700 (PDT)
Received: from fedora ([2a01:e0a:257:8c60:80f1:cdf8:48d0:b0a1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c7df3506sm3076694f8f.11.2025.03.13.11.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 11:48:57 -0700 (PDT)
Date: Thu, 13 Mar 2025 19:48:55 +0100
From: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
To: Harald Mommer <harald.mommer@opensynergy.com>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Mikhail Golubev-Ciuchea <Mikhail.Golubev-Ciuchea@opensynergy.com>,
	Wolfgang Grandegger <wg@grandegger.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Damir Shaikhutdinov <Damir.Shaikhutdinov@opensynergy.com>,
	linux-kernel@vger.kernel.org, linux-can@vger.kernel.org,
	netdev@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH v5] can: virtio: Initial virtio CAN driver.
Message-ID: <Z9Molw9U+1MYCtFh@fedora>
References: <20240108131039.2234044-1-Mikhail.Golubev-Ciuchea@opensynergy.com>
 <a366f529-c901-4cd1-a1a6-c3958562cace@wanadoo.fr>
 <0878aedf-35c2-4901-8662-2688574dd06f@opensynergy.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0878aedf-35c2-4901-8662-2688574dd06f@opensynergy.com>

On Thu, Feb 01, 2024 at 07:57:45PM +0100, Harald Mommer wrote:
> Hello,
> 
> I thought there would be some more comments coming and I could address
> everything in one chunk. Not the case, besides your comments silence.
> 
> On 08.01.24 20:34, Christophe JAILLET wrote:
> > 
> > Hi,
> > a few nits below, should there be a v6.
> > 
> 
> I'm sure there will be but not so soon. Probably after acceptance of the
> virtio CAN specification or after change requests to the specification are
> received and the driver has to be adapted to an updated draft.
> 

What are the changes in the specification that should be taken into
account for the next series?

Thanks, Matias.


