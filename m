Return-Path: <netdev+bounces-258639-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KMSOEeVNj2nnPgEAu9opvQ
	(envelope-from <netdev+bounces-258639-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 17:14:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 687F7137DCB
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 17:14:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 71FD53042FF9
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 16:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876EA3612F4;
	Fri, 13 Feb 2026 16:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="htQ3ydDf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A309F356A10
	for <netdev@vger.kernel.org>; Fri, 13 Feb 2026 16:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770999254; cv=none; b=NUq+fx4ZtWFVKQ9mjdiJM661qwl+amzkL1xEL4cT2/7jJDFX3pAkS/c2rShXjisbi37X0EYAKdW6zDr5BRtW+9v3g6ct08qCP4Sz6rC3HruO0YwH/TpPx/ZiuOHsAFKi6BaFJAxF6bopjp1i1zdrnevSMrfU2f6juC5book/tKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770999254; c=relaxed/simple;
	bh=V51ablEssrNSfKuX1Hq5OtUiYKCcf8X5hv6UEk8jGlA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qBrIK6jcMfeilWSiREd2CNPH8INv6u4UNNc/W+TzYNHKBFIEgeWRw0lDw4z/28I0Q/MccIhA1p1qUu4rJhjVbd3AX/aAUx76SC4tuGheMdZrvM565DlOIfzwS98s01ibOvSJLw+bnTVQ+8q6A6ie8cLhsuqb5H4p+TJlb/wRWv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=htQ3ydDf; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8c70ce93afaso120295885a.0
        for <netdev@vger.kernel.org>; Fri, 13 Feb 2026 08:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1770999252; x=1771604052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=thDqtYQ9svVncr7vS9+e+A5WECJReTFglHn4jfgM4PU=;
        b=htQ3ydDfBsUQ8o5IcIz7d8e0mIrmgh/YE104UM9pf528zXXMgtlsySDb+SXM5apGXq
         3ZW+M2d28jLP+KUxxSSILcC2GORDOrpvP+82bPw8vwxcc4X2Ax/GozqGfxzzxzY8E2a3
         SYLhRapxSr3QRdnJ/QCBSPxyQchGWX32jDFrZ9jYPCIFHe0wGYDM6N77YF6nvilVVfN5
         KB//suc54zTPKxVM8Uo4Zpp5UgR0mAaApcHgAqLEJKu3m8uOug9qKZrz9+JfheimKbI7
         6fzKANZwXl8xGgfzlrJfELvGPwq/2iKXfMj+mfzTCaPx8IS4HUzsUQKqN8+c/BjX0d0N
         iczQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770999252; x=1771604052;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=thDqtYQ9svVncr7vS9+e+A5WECJReTFglHn4jfgM4PU=;
        b=awZXQOXvXKd2iCeuFEl5FfMjfyoSipk1/OmnFfaI1bBIHdaZtAgBtSl7v/Pjyk3GfR
         u/t1cgVpctlgVQ4R4bfiR6fniX473EfgMd6272CAGK4U5XZYf28sRXD12MXdBaUT0Jhk
         be9voYjfbMH9cBkw1ND/R7TKWqX+vLqSxG6L7vVfGPX6d5V5YAJI6bu605id9XFs6NS1
         gLCIEwpZfDW65zG4qsFYm8aZiuAqUgNLh5NUEabTq76ckA48yGujybEshyG+2Y6L26nS
         4bL3jYe+XghbQBtex+rufvnk50zyJV+dLk0EBu9CVo/ORBo/Wx1lyJCZsCg/C6i9XdNG
         EfNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVID6KzufKIcWl74SX3FPhg9VpZVpol2KuhOEJpaIW/872jh/sg9CrAxqeWdm4eMb0F/hiCWhM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUSGYtOBSWZd2ySpFv9y96+Pi0NM3nfsMkm22cYTrlt7BIqXer
	uHpSv50WiQk74WtVFqROXau+zYQk1IAjrwwF7nQIDBwAvb6OY6PqRowhAylY6XzhLTdHBmRjr0l
	TKao9
X-Gm-Gg: AZuq6aKy3XGFYYjEF5A4cVVjcd3bnZONECsYENL+aldLyCcTFRLVw/gTC8cs/KgTSmW
	mFOt1y5gI8FUBKSNTsP5fqI4L/EH6E2y9zwetzhFG2ewF+DIcJBUkFR4Dp5pFVG62YJIVVe4YiY
	ZTqwGg0kZaU2NpQKs/v5FnbMujaygw37tyXnZihEU05WEK706Sx8f2p8t+lvRqmH2XynLrt74D5
	esi6yQzrDSveSA0KzhCxXvVKDOmc9wL/jcTeV/PBopETlgSZJfK0/+NyNDa7pBILqXAuo0GYjou
	GVF3vrPK/abzTviM39JBkl02x7kk7duY7d6AFKcrtkhiVR4f9EWFqdMaQpOGoQrSiA0L2NAF+hC
	kgFXlPIwFUpDTnZZJhm1aEmAt4nzjZP2X7FbP7dLsFbbpf2cKDbZyBNyU3FFDA5lFAtGZV4Rfl8
	qy9ZTZ546JehDCtif/XMRG7fomdDJcLi0j/3xc6xQ/QMd2kwTMeK0I8gqObxzN4dfrItnLVbVg/
	teYmo5LV92ev+asPkpuTIQwXQ==
X-Received: by 2002:a05:620a:46a4:b0:8b2:d72d:e41c with SMTP id af79cd13be357-8cb422549c1mr296857685a.5.1770999251629;
        Fri, 13 Feb 2026 08:14:11 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb39da3dc6sm401861185a.51.2026.02.13.08.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 08:14:11 -0800 (PST)
From: Gregory Price <gourry@gourry.net>
To: Alejandro Lucero <alucerop@amd.com>
Cc: linux-cxl@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 14/22] cxl: Define a driver interface for DPA allocation
Date: Fri, 13 Feb 2026 11:14:05 -0500
Message-ID: <20260213161410.2945294-1-gourry@gourry.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260201155438.2664640-15-alejandro.lucero-palau@amd.com>
References: <20260201155438.2664640-1-alejandro.lucero-palau@amd.com> <20260201155438.2664640-15-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gourry.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258639-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[gourry.net];
	DKIM_TRACE(0.00)[gourry.net:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gourry@gourry.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gourry.net:mid,gourry.net:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 687F7137DCB
X-Rspamd-Action: no action

This review was generated by kreview-0811365ff2. =0D
=0D
This is not an automated email, the reviewer though this report=0D
looked valid enough to consider discussion.=0D
=0D
----=0D
=0D
Cursory browse, this does look like a legitimate reference leak.=0D
=0D
~Gregory=0D
=0D
----=0D
=0D
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c=0D
> index a172ce4e9b19..d60a697f12cc 100644=0D
> --- a/drivers/cxl/core/hdm.c=0D
> +++ b/drivers/cxl/core/hdm.c=0D
=0D
[ ... ]=0D
=0D
> +static struct cxl_endpoint_decoder *=0D
> +cxl_find_free_decoder(struct cxl_memdev *cxlmd)=0D
> +{=0D
> +	struct cxl_port *endpoint =3D cxlmd->endpoint;=0D
> +	struct device *dev;=0D
> +=0D
> +	guard(rwsem_read)(&cxl_rwsem.dpa);=0D
> +	dev =3D device_find_child(&endpoint->dev, NULL,=0D
> +				find_free_decoder);=0D
> +	if (!dev)=0D
> +		return NULL;=0D
> +=0D
> +	return to_cxl_endpoint_decoder(dev);=0D
> +}=0D
=0D
[ ... ]=0D
=0D
> +struct cxl_endpoint_decoder *cxl_request_dpa(struct cxl_memdev *cxlmd,=0D
> +					     enum cxl_partition_mode mode,=0D
> +					     resource_size_t alloc)=0D
> +{=0D
> +	int rc;=0D
> +=0D
> +	if (!IS_ALIGNED(alloc, SZ_256M))=0D
> +		return ERR_PTR(-EINVAL);=0D
> +=0D
> +	struct cxl_endpoint_decoder *cxled __free(put_cxled) =3D=0D
> +		cxl_find_free_decoder(cxlmd);=0D
> +=0D
> +	if (!cxled)=0D
> +		return ERR_PTR(-ENODEV);=0D
> +=0D
> +	rc =3D cxl_dpa_set_part(cxled, mode);=0D
> +	if (rc)=0D
> +		return ERR_PTR(rc);=0D
> +=0D
> +	rc =3D cxl_dpa_alloc(cxled, alloc);=0D
> +	if (rc)=0D
> +		return ERR_PTR(rc);=0D
> +=0D
> +	return no_free_ptr(cxled);=0D
> +}=0D
> +EXPORT_SYMBOL_NS_GPL(cxl_request_dpa, "CXL");=0D
=0D
Does this leak the device reference obtained by device_find_child()=0D
in cxl_find_free_decoder()?=0D
=0D
device_find_child() increments the device refcount (reference A).=0D
Then cxl_dpa_alloc() -> __cxl_dpa_reserve() calls get_device() on=0D
the same device (reference B).=0D
=0D
On the success path, no_free_ptr() inhibits the put_cxled cleanup,=0D
so reference A is transferred to the caller.  The matching cleanup=0D
function cxl_dpa_free() calls __cxl_dpa_release(), which drops=0D
reference B via put_device(), but reference A is never released:=0D
=0D
    cxl_dpa_free()=0D
      -> devm_cxl_dpa_release()=0D
        -> __cxl_dpa_release()=0D
          -> put_device()     /* drops reference B only */=0D
=0D
    /* reference A from device_find_child() is still held */=0D
=0D
The only caller in this series (sfc efx_cxl_init/efx_cxl_exit)=0D
never calls put_device() on the returned cxled either, so the=0D
endpoint decoder device refcount remains permanently elevated.=0D

