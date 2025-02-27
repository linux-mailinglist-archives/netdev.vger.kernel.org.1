Return-Path: <netdev+bounces-170182-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A81C7A47A42
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 11:25:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF1961712CB
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 10:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C64C422A4C0;
	Thu, 27 Feb 2025 10:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ct7ckqjP"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDB81898FB
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 10:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740651895; cv=none; b=GH0GXAngPK/l+hSDSJlbpdCPyRlAhO3QtB8UrrWsqUboc/1S8PG/NXhbqtOJEh4oKisG+iNSa7dfV6U2PJrshUbeWaqFMhF61X07DdUozYBRaKzh024UjV0kOJRfRjYZBJ00kTATWHPf+XWRef7k7q2679Php1oVY2UHROcNpZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740651895; c=relaxed/simple;
	bh=YYX5Y6x8sVNtWqEWCHNDXuQkb2mtaSvdi9UEEpL/J1o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZsSob9++ibsWeb9S/Yuvj18qfQe7uvNx0rGgpdpbyHFtJWJqSlMjTXJkyj2gJzbf43vQ8q07NAuyuZAyRxQ5D4D35trGluALLI9u6JvPb2Zx1gdZjgqCxb3igE0rhyLrtpsn9FtM1GrugEKy79dji9hseXSR5S11GQGWAU2YngA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ct7ckqjP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740651893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YYX5Y6x8sVNtWqEWCHNDXuQkb2mtaSvdi9UEEpL/J1o=;
	b=ct7ckqjPrYoVRjliRpYfl3qFPyRt2RNPFOkarw0Zb81nWrDhwR6nJ0zRIKa2zYC+B/AoNl
	Am7E8F5IdIuysyawIYLZHkTNmvfKOyiaWI23hi165KhOWXaIqEcldQcCdjDiuzoSkpj4dy
	Vs/TewJLoAr5zEebWphASMimTWDpGZU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-278-VEe8PQtZMpmD2tKdgMd7OA-1; Thu, 27 Feb 2025 05:24:51 -0500
X-MC-Unique: VEe8PQtZMpmD2tKdgMd7OA-1
X-Mimecast-MFC-AGG-ID: VEe8PQtZMpmD2tKdgMd7OA_1740651890
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4394b8bd4e1so4135505e9.0
        for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 02:24:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740651890; x=1741256690;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YYX5Y6x8sVNtWqEWCHNDXuQkb2mtaSvdi9UEEpL/J1o=;
        b=QpJ60WKf4joJnYc2h+SbUm1hrZf6cq3hEGZYZDcUVCm/1vdUjw8gYzV4jbrVWYakF7
         WsB7gHPyaKMk/Ft0AQzGZ5hGJmK+hP0HoJ4Yk1hgWlDNMP3evyv4DOyifq2aL4E09Lnk
         2i0NCijy7HCqiFTxYqriIvGmrSOA7vnW3FELzqvF6F/OjLuXlxGUjqH+h//efoj2jnVF
         56tXJtbINnWB6QVlVot1vMP+fdHPeEu/93PPWl5QIJUw/mK3GcVYpx+FC06MEoP8EB8p
         lUL1oZGXYX912hlgJkveGNPiw0eiFXXJ2HBlb8MIYGWUmHKTKSu48gAVKxIVp9WZbrDg
         1AKA==
X-Forwarded-Encrypted: i=1; AJvYcCUHazF+rdNJoSNs9k/7kbt1/A6odk/TzQS2MYq3UxMJeFaFlvp9auy7Vu/XHT2TQeobwvDErkI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwE+C5P6b/EaLWM5cWXW2K/NyhZirR4T6UV/qBztsMPsOAVmNkH
	7Y0mvmwAbTSNdBgQl3SM8IfMWTRSBGDpHXVzpnyWYxHITNhhEw/uAme4LZ2lpOrkaTEuK0quV9d
	1eFdirZCqaVAarE6qYCYYJLCUn7pztEocaH2+bkqtXhXt2zImbein9w==
X-Gm-Gg: ASbGncuSpwZEDD3GSF5BQE09H0C3Q1AWzc785sS4OvYu7tB84861AAlBkAH+8CrN/L7
	31DAGValBsk1566v6okwYv7z3CoXnDjjEkdA2PbI0atk0p3cma5yJOherUshdb0oCIv5ONNqU2v
	PjaiNK5l7F4ctTFaRDqd74yTFpIucQjqaCAUm7Ge409dslKHMPBLdeiR21/nov4Ftc0+C9ns95T
	UTN2JohGUI+St3sPEHE7+6JL6BoK+clxh3RUte80Df6Z6cAu4y9OdLIKWfL9v4ZFq1d6qbBrq+a
	yd+FHxACvT/x7dO+9k+9ylA4L/vHz6rCJxvksoF97MzUvw==
X-Received: by 2002:a05:600c:4fcf:b0:439:5a37:8157 with SMTP id 5b1f17b1804b1-439aebf3613mr245216585e9.30.1740651890261;
        Thu, 27 Feb 2025 02:24:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE8N+SGDfS2sopNFZtZ5Mn79q9qVg00ddErNII9bO79/XW8bgD6mRD8xzkPQyBtEOZqB0OjPA==
X-Received: by 2002:a05:600c:4fcf:b0:439:5a37:8157 with SMTP id 5b1f17b1804b1-439aebf3613mr245216385e9.30.1740651889915;
        Thu, 27 Feb 2025 02:24:49 -0800 (PST)
Received: from [192.168.88.253] (146-241-81-153.dyn.eolo.it. [146.241.81.153])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e485db6csm1566929f8f.91.2025.02.27.02.24.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2025 02:24:49 -0800 (PST)
Message-ID: <ec8fbe36-138f-4a0b-a8d3-95e49187a47a@redhat.com>
Date: Thu, 27 Feb 2025 11:24:48 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 4/8] net: pktgen: fix mpls maximum labels list
 parsing
To: Peter Seiderer <ps.report@gmx.net>, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Artem Chernyshev <artem.chernyshev@red-soft.ru>,
 Frederic Weisbecker <frederic@kernel.org>, Nam Cao <namcao@linutronix.de>
References: <20250224092242.13192-1-ps.report@gmx.net>
 <20250224092242.13192-5-ps.report@gmx.net>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250224092242.13192-5-ps.report@gmx.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/24/25 10:22 AM, Peter Seiderer wrote:
> Fix mpls maximum labels list parsing up to MAX_MPLS_LABELS/16 entries
> (instead of up to MAX_MPLS_LABELS - 1).

Very minor nit...

The above comments sounds misleading to me. I read it as the new limit
is MAX_MPLS_LABELS divided by 16, that is 1.

Thanks,

Paolo


