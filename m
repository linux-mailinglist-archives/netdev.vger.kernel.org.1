Return-Path: <netdev+bounces-68443-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C7E846F24
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 12:40:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E23BFB29862
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 11:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9337C13EFE1;
	Fri,  2 Feb 2024 11:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cua/KP5x"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28DE13E23B
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 11:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706873936; cv=none; b=fEOixKVtMdYgmV9H42TVMV+BigujHdqvq9+jmpWlZvwAFQMDFhlFT9S1aORsGy84Ladslu6t2e5YGb2czefmOh3mtnM5i2SloDwGpNUsfYAeffp5L0RUNyBnEPo0OsN5IxG3T1LgEe3hvTZyBqaiKONpTKMiJ9K9Ht5IrfNy3U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706873936; c=relaxed/simple;
	bh=4hlLoxgVRubmdsXA/JOtymfDpB123MgdtvEfROpDl+0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Y3XII/ojoQQNTJSl0VuHh5C++TC94/SQ6H4XR2D4e4onYjKiKae+U5aubCgcvmGP0Ch/DTBGcwYq6G6yMGhUtBSFk5qzwPmEQZRCPE3p7Q6lbqDFdjK5CvFyTOkbPsOo1CR4aq8X+fIRnplG+36m5LqID7n9xtNtr3rJXZ4lQqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cua/KP5x; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706873932;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4hlLoxgVRubmdsXA/JOtymfDpB123MgdtvEfROpDl+0=;
	b=cua/KP5x8g2GZSLNqyXeP5OBBj2V+w008X4v1c1ZDuVO6rTwcv9hHsUvYBAqIzVxNd87A+
	eXOSbe8yyWNVxYnXixFWgedtghxSaQBI2WoLkXlQTl7HE4S4IuhYyl6gzAYVUihxP/Y/ce
	WyG7hujBE3KxsOCv/qGMFKERLfoU+wI=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-jX945PpkMX6fwMiKUYgymA-1; Fri, 02 Feb 2024 06:38:51 -0500
X-MC-Unique: jX945PpkMX6fwMiKUYgymA-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a358c652e42so118875966b.3
        for <netdev@vger.kernel.org>; Fri, 02 Feb 2024 03:38:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706873930; x=1707478730;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4hlLoxgVRubmdsXA/JOtymfDpB123MgdtvEfROpDl+0=;
        b=M4UyIiV1bmpgmzFFhlWSmX6cB1nOKcAy/TJa+YihDMuJTkHg2nOY02ac4bSGp/tAJV
         tsyU9JMSEWCaMAi7KwyyUaR5Zg/kOdm23Yy6zAQpWdKWKGjBQO72nGOTol/cW62cCbru
         0uO2pvOl1UmDWHnskv2zon6dkbx/JJWjyvgvLytzO1QRYRsxb4ghR2W3xNLBhHvmzl51
         M6E3Ua3/nejvz1VhWX4f+hP7v820If/TytMnYhMXaOdDQwz4UYF54RWTbE7iY6O7XQPa
         B+Nn6SsYQmJM0YRsSS6tf/QsctsrBO1wDxtPM9G5TmMspw+UUtjToEdbwTuo/VWyEtxh
         Feuw==
X-Gm-Message-State: AOJu0YxQyWIvYJEclT4WmAsVnLovYPdjA/gaI+sHJKrDyIFB3HP1BMy9
	Fr8fLN3cOt7JlypDcDtmbWZEv8nsuPIQktV59ula+UA/OCbxrBUhsAIyw19u0UhQ/PnMcndPiuw
	VB0HzklpoWOBv317GNgk2ewbXMXiXI51KMgU2BNB3XMT4Mp75JJaP1g==
X-Received: by 2002:a17:906:15d8:b0:a31:f7e:8a53 with SMTP id l24-20020a17090615d800b00a310f7e8a53mr1343355ejd.26.1706873930320;
        Fri, 02 Feb 2024 03:38:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGxEAJunAEUW/L3MFJKR31vN1MxxW5woPZmhc5v2fwcaBQ9f38xfilE5aVLH0gmvNqQ5Q13ng==
X-Received: by 2002:a17:906:15d8:b0:a31:f7e:8a53 with SMTP id l24-20020a17090615d800b00a310f7e8a53mr1343337ejd.26.1706873929992;
        Fri, 02 Feb 2024 03:38:49 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCX4/KG5Hy4D3W6/JBc0krwsLJY4D1i5j/cUA45VUdQFA8tENeMlpGHHU4/BGh8Doavma3fd6YuLy5krCvfSam1MQ6ieOolQu31kz+w9bOzMqgjjnOlS0WV98FTdIi7yI8uWyKkMfjmvKvhQcHI/ZvK86lCXe8ysA3qsQ+lJzdfh2CqUqUMaEdsKpEohirM+xL1Jru5nbR6kqL74hPuFynzdwyWuG8ySqcZbd14/2hfZUQRv71G34cZYhzRn2AQbUKx+2/Fld43qEetm7suF6p19LacOzQIMf+TsvrxrAGb3K513ShimALlA1LNZW/P3WYRqW+FbmC3Zi1gijZ5O6l/8BlI1GzBr5kUZMyzPxX6x1ZjB6fOdMscxhRRksaZ+fU/p1hgRxa12b802vyYGGkg8unF7ahM=
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id p4-20020a17090628c400b00a360239f006sm792261ejd.37.2024.02.02.03.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 03:38:49 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id CD464108A835; Fri,  2 Feb 2024 12:38:48 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>, netdev@vger.kernel.org
Cc: lorenzo.bianconi@redhat.com, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, bpf@vger.kernel.org,
 willemdebruijn.kernel@gmail.com, jasowang@redhat.com, sdf@google.com,
 hawk@kernel.org, ilias.apalodimas@linaro.org, linyunsheng@huawei.com
Subject: Re: [PATCH v7 net-next 1/4] net: add generic percpu page_pool
 allocator
In-Reply-To: <1d34b717f8f842b9c3e9f70f0e8ffd245a5d2460.1706861261.git.lorenzo@kernel.org>
References: <cover.1706861261.git.lorenzo@kernel.org>
 <1d34b717f8f842b9c3e9f70f0e8ffd245a5d2460.1706861261.git.lorenzo@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 02 Feb 2024 12:38:48 +0100
Message-ID: <87v877xfhz.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Lorenzo Bianconi <lorenzo@kernel.org> writes:

> Introduce generic percpu page_pools allocator.
> Moreover add page_pool_create_percpu() and cpuid filed in page_pool struct
> in order to recycle the page in the page_pool "hot" cache if
> napi_pp_put_page() is running on the same cpu.
> This is a preliminary patch to add xdp multi-buff support for xdp running
> in generic mode.
>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


