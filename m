Return-Path: <netdev+bounces-237342-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 548A1C492B0
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 21:01:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F154A3A19E6
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 19:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41DF927A107;
	Mon, 10 Nov 2025 19:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZH08I8WN";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="nITB561g"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8626033F396
	for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 19:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762804760; cv=none; b=SVzQRfFqVuMkoG+jm+M2nPheO4xxqA5LdhNDS63SMxa6kTS4WHbdcs3UncDlB1AJKRzy4NrjUSIlslN2cs/pp9oxemOzwEak5ySU+FfoS9Hct6k3BuZ++R394RBKvhbuKnoNjZoV4ypcM+S2SCiWMdIADlvgdHr0pkSUJ9DO5yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762804760; c=relaxed/simple;
	bh=Kv6OEQHPSyfYr4guOC8UM71X8vaCKzOPKFEVCNEGK9E=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=HpEehqijeWdC4p8Kv4ukFwG6UaLbrn2+q3D+PPbYHyRU6VmzTXKfqGEeXzWUoaOeqjyWksvXm7+LQtZ/wJWob1u53uHkBJ9GP9YoR3HLhtrk3ca5RUe+hlJrD4pVE0zf+uY8c6DoIZuJBJasYSZ60TINPYgJL5/7OQD/vEgqNck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZH08I8WN; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=nITB561g; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762804757;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3RsWgSzH6rHPJyGNBCXIGPTC0wMGFyi4I96OoFvQDm0=;
	b=ZH08I8WNrpQkGk+4amJi2L6+/EihYNbENAoLvSN96O3GtpGK4ho4Rowsj0/vrENovs4F8F
	5BxPHThWa3//BhjtaQZ0ENaKGoxmr7waa0JdOPnKmQ7mIY3dJHfJ5a1S4SqQOQGs2QhKlz
	8y6B/dAdnhjDA41mSIkwnOk/PfN/ADU=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-252-Aocn62OTOUG9N0zzOW_i9g-1; Mon, 10 Nov 2025 14:59:16 -0500
X-MC-Unique: Aocn62OTOUG9N0zzOW_i9g-1
X-Mimecast-MFC-AGG-ID: Aocn62OTOUG9N0zzOW_i9g_1762804755
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-64165abd7ffso2521544a12.0
        for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 11:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762804755; x=1763409555; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3RsWgSzH6rHPJyGNBCXIGPTC0wMGFyi4I96OoFvQDm0=;
        b=nITB561g/BLAsAnSa0rKCKB3c7GLHd4BFePapLUk/6VxdA7knfMKruEF3+dpO/zZZm
         mY+rpFdgzwMHjGsiYr5aKgYAxmalYmuf/y/4sWvyPkexa7+K8C6eF9juzfT+WV+NcmAM
         egsUEuVKlCZnBvqoKuWwamfogLXz94UBdHzUI7R7Xm0SONII7gowIEen5YZONnIMBmhg
         KIsIV4cO8I57396vaYjh4yClyIBW6ocOVGNywPz527SZFDmOSHklpHyFcRBaIT+tcN5Q
         MO53qpUv7sHn4MWtYPTQjk5QEhFLnMg1XIdExggWlt0SsiJVAWC1VHuxSQV1LT/fTSjp
         HtmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762804755; x=1763409555;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3RsWgSzH6rHPJyGNBCXIGPTC0wMGFyi4I96OoFvQDm0=;
        b=qZRNCIqMADPPN54iLYOZY7PHqmysnC7OJVCITf0bY9J6+Sbm8hbc8XlfIY0lMzzgQ6
         2bHJ8fIFi+/6Wsxqg2eUAGySzvpSQjyG0dgrdaypCKuoLM3Lzlg98dhsElM46+dK5/7g
         9SLyiLjMYlOymUU2J0aB3svv3qBASWnB3VW+8oEwF0XVH+sDx3y+funbpqvSGlBe5jPn
         v31slF/Ppdn/UzHXPu4s2LMDNLRetAD9rgrgMqSBWrzD2oYABDFEc4aaTtrmdCQssRyA
         JGTJNjxDbOUusweMt9zhTuo4R4JD3/Wee/6WSzOW4k30WDJaF0HlxPpwysRvmp+KcdyQ
         Fpmg==
X-Gm-Message-State: AOJu0YzjS/Nyv63MX/SIiuJF+UU72YVJxhZMKbr8RLunowYz3H6Ye+3R
	ngPun/BOXKyBMKl0ZiOJo7q44w1XiNPULCsiLJXJ+n0ElHHmTMb+7wL9tXVCZVm0qIJKET+lA1q
	TymCTqW70ZIYwsIQ5FrMr6kZzL+mssNfvCDvied6BLFDqvSKDZtZ5QsKldQ==
X-Gm-Gg: ASbGncvgOOYaKkPUsP6r/kSVr14Ti/bd9U/aiXFw4rsRGqRaIgZtuGgaci/4ev1bVOv
	7BSsxnjX7ykXJvZdzDZ4RE264i96Vj1Y/mK3mrytAJu1xSClO8i+R1nvkSuDA4fCw2hBWPkUyPG
	hz17RR7Xv7G4dLmZoDsonfE0t7cIinZ41gRACZw2c8j8qKuTIAu/WrtpJHv0wbY8lDxo7ZVfy5A
	OIRjBab2ng/Edmg3eErdRsnTO6+aeNWjxzFsfj6YY2S5l3KPk+zwyeGT6gCI5Y7NLc5aKzCWsDk
	sjffo3xAv9ztKD6dEfKId2N7Yx2jESP+FGCe2KHfvSqk2l7VNQ7uSzGjGfWLE+GTpJ05Z+SG3Ph
	a4RD9A6s=
X-Received: by 2002:a17:907:3f13:b0:b39:57ab:ec18 with SMTP id a640c23a62f3a-b72e045a978mr1034366366b.45.1762804754738;
        Mon, 10 Nov 2025 11:59:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGOORfYifGPO/tqQYVwjTKCs4WjcWYFtJ555ogsgEFdKX6Br8ADRGUVflW5pvv9vCn9Gmcf8g==
X-Received: by 2002:a17:907:3f13:b0:b39:57ab:ec18 with SMTP id a640c23a62f3a-b72e045a978mr1034364366b.45.1762804754353;
        Mon, 10 Nov 2025 11:59:14 -0800 (PST)
Received: from ehlo.thunderbird.net ([2a00:e580:bf11:1:a362:f3ff:b8f1:3cf7])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf311fa3sm1153287666b.16.2025.11.10.11.59.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 11:59:14 -0800 (PST)
Date: Mon, 10 Nov 2025 20:59:13 +0100
From: Ivan Vecera <ivecera@redhat.com>
To: Kriish Sharma <kriish.sharma2006@gmail.com>,
 Prathosh Satish <Prathosh.Satish@microchip.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>
CC: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_dpll=3A_zl3073x=3A_fix_kernel-?=
 =?US-ASCII?Q?doc_name_and_missing_parameter_in_fw=2Ec?=
User-Agent: Thunderbird for Android
In-Reply-To: <20251110195030.2248235-1-kriish.sharma2006@gmail.com>
References: <20251110195030.2248235-1-kriish.sharma2006@gmail.com>
Message-ID: <1A4EAB2B-A848-4571-88B2-A33A850F272F@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On November 10, 2025 8:50:30 PM GMT+01:00, Kriish Sharma <kriish=2Esharma2=
006@gmail=2Ecom> wrote:
>Documentation build reported:
>
>  Warning: drivers/dpll/zl3073x/fw=2Ec:365 function parameter 'comp' not =
described in 'zl3073x_fw_component_flash'
>  Warning: drivers/dpll/zl3073x/fw=2Ec:365 expecting prototype for zl3073=
x_flash_bundle_flash()=2E Prototype was for zl3073x_fw_component_flash() in=
stead
>
>The kernel-doc comment above `zl3073x_fw_component_flash()` used the wron=
g
>function name (`zl3073x_flash_bundle_flash`) and omitted the `@comp` para=
meter=2E
>This patch updates the comment to correctly document the
>`zl3073x_fw_component_flash()` function and its arguments=2E
>
>Fixes: ca017409da69 ("dpll: zl3073x: Add firmware loading functionality")
>Signed-off-by: Kriish Sharma <kriish=2Esharma2006@gmail=2Ecom>
>---
> drivers/dpll/zl3073x/fw=2Ec | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/dpll/zl3073x/fw=2Ec b/drivers/dpll/zl3073x/fw=2Ec
>index def37fe8d9b0=2E=2Eca5210c0829d 100644
>--- a/drivers/dpll/zl3073x/fw=2Ec
>+++ b/drivers/dpll/zl3073x/fw=2Ec
>@@ -352,9 +352,9 @@ struct zl3073x_fw *zl3073x_fw_load(struct zl3073x_dev=
 *zldev, const char *data,
> }
>=20
> /**
>- * zl3073x_flash_bundle_flash - Flash all components
>+ * zl3073x_fw_component_flash - Flash all components
>  * @zldev: zl3073x device structure
>- * @components: pointer to components array
>+ * @comp: pointer to components array
>  * @extack: netlink extack pointer to report errors
>  *
>  * Returns 0 in case of success or negative number otherwise=2E

Reviewed-by: Ivan Vecera <ivecera@redhat=2Ecom>


