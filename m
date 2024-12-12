Return-Path: <netdev+bounces-151345-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E65A59EE49A
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 11:59:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8EB1281BAC
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 10:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE8B211485;
	Thu, 12 Dec 2024 10:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e9JaYYMk"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D616521146B
	for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 10:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734001146; cv=none; b=VakE5g8vABbhgWc+rwwm1czKbKz6mE39FEB1DAgoHoic1NmhwLCfqAr8B8vY6Hfdw4QffQe18IMjFFlv4cGBfdRlgsch75+cgfPZqTNhLNkgHP0ocW6XmUxOZM4mxVJsNejhX53V4uVLKI9pDSkH2wEHPRp7pC+n4GM2FowSC6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734001146; c=relaxed/simple;
	bh=0rpgITi/RceK75eiLzwMBoatVGcV6ayulEuHj23hD2s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bME0A1Pi4fT6Ofmsv5uMSqp2inLP99IYe1eJnR9fGtT3r5HfXX93VJhlwzokwRGXVC/ttEJzpsayqAp9Z3Loz8HItttGNsJsYEDQIcMJhh+RK3AsfDuYCUWI6R5mzJE59v2PjX+RZkHT+Tu3dh0AMjOYQzQhJCqi+1OFgz79nMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e9JaYYMk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734001143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k6LMp3yhvNH7iDTlgkjr0Y+pCZOZC730ryRam7ekrww=;
	b=e9JaYYMkpzQQHDyVIQPU9+HB+Q+UMsHMCcnI22uyMst8ArNj+0SzhI06qVs+mPbpFucJVC
	8QltO9RFHpRnjSngZTCUKMcpCTiNMb3pcfLpwu4xO8Stl139kJv+AmSu3jJXTCPy6J+7j9
	0+N8EQTQldxB98dcvl5N4h+AgnJ5zGs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-314-ALKt-AHvPAS14mbFoOQXqg-1; Thu, 12 Dec 2024 05:59:02 -0500
X-MC-Unique: ALKt-AHvPAS14mbFoOQXqg-1
X-Mimecast-MFC-AGG-ID: ALKt-AHvPAS14mbFoOQXqg
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-434fe2b605eso2898845e9.2
        for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 02:59:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734001141; x=1734605941;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k6LMp3yhvNH7iDTlgkjr0Y+pCZOZC730ryRam7ekrww=;
        b=vSaYOAF1lOY17oI+vtXWyYckR0OZ0b89DhcsnqntCNVXFsyJKeuS7AiGQszE9MKSkt
         uaQvLx0DNZlXhLPU7OR3WlagTN9Lid3bzez+32tIckHWG4cKpNNb/3fDWtd/cfrmYAHT
         RZqP/VYDMR55ga60+gb6fu+giaXYdYHN+bKxiqYRZ2yXsBnwIiYtIQLgVlOMihIpeffc
         n9R6C1Qx1ggZBY4c1+Ed/baZqld0Vd+qLaBmsdDs173SY1HGpqcZqPI7Chq/lGvWPafP
         BlFrH4rcURz3GmWz+2wsBw+oAZ+YNOtjZOi8cyt84h3YedYYT3yTdnrfFHJ60IB+E5ig
         KacQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqbQCpN+Hc2BT+ZxpJ8DfVumZnjyQIX74p4NubJ466lzrzVy58XvzLNWxjIMUk4BxP5G9Ha6I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIySILTwXAqQIG65s34+0BES/lAG5HoDvcS4blwTZM2Dyh9eA5
	XVjm6SH+roUKCwQbA2X0jqoUAYR4dbuCo8ViUudSMZ6kSXSjy0lUmlaDpm8slQVoLJAwc0WmJo+
	iLzbzRgqY+DPfnHXxNAH8VZiQtz6eqEO+gHox1PWtvlUgEAmVg399PQ==
X-Gm-Gg: ASbGnct+byVf7b5iKaDpRuTaxx5XECPWRGpYHavl5sT2tvxk+TD+B6CaaQNGP60AYsg
	mBuVfOyIPk4tnd47HalEhCmpeS+mpdDQhFxCeli8HoMEBmiLAzGhKJr64vcIuMvyFucfjLlaX8U
	kltjj8TeoIgxkaHikgRl7hmJYhxWfhoUgIeHIIPq9YkbD0dW+Y+RYsiq112MtVOLm8eI1cPA/eQ
	xMdp9OhAfhlWVaqmAoqgdE+wxJs2WZtsDiNZutO3frjvrsOqbUjcNeloAeq1LhSO35OMDlXyaQA
	MM0Mwfw=
X-Received: by 2002:a05:600c:468c:b0:434:9936:c823 with SMTP id 5b1f17b1804b1-4361c387b63mr51504535e9.18.1734001141115;
        Thu, 12 Dec 2024 02:59:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGoVxQVOMsuvx1qd2xoaOEr5HS5OrNbDZIhPIUPF2afE1X/8AvjHvAcnq4miXjTWtR7LQiBWA==
X-Received: by 2002:a05:600c:468c:b0:434:9936:c823 with SMTP id 5b1f17b1804b1-4361c387b63mr51504415e9.18.1734001140831;
        Thu, 12 Dec 2024 02:59:00 -0800 (PST)
Received: from [192.168.88.24] (146-241-48-67.dyn.eolo.it. [146.241.48.67])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4362555334bsm13179245e9.1.2024.12.12.02.58.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 02:59:00 -0800 (PST)
Message-ID: <9a19f3b4-d1f9-4686-968c-55bf80e0f3c5@redhat.com>
Date: Thu, 12 Dec 2024 11:58:59 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/5] net, team, bonding: Add netdev_base_features
 helper
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org, mkubecek@suse.cz,
 Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel <idosch@idosch.org>,
 Jiri Pirko <jiri@nvidia.com>, netdev@vger.kernel.org
References: <20241210141245.327886-1-daniel@iogearbox.net>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241210141245.327886-1-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/10/24 15:12, Daniel Borkmann wrote:
> Both bonding and team driver have logic to derive the base feature
> flags before iterating over their slave devices to refine the set
> via netdev_increment_features().
> 
> Add a small helper netdev_base_features() so this can be reused
> instead of having it open-coded multiple times.
> 
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Nikolay Aleksandrov <razor@blackwall.org>
> Cc: Ido Schimmel <idosch@idosch.org>
> Cc: Jiri Pirko <jiri@nvidia.com>

The series looks good, I'm applying it right now, but please include a
(even small) cover letter in the next multi-patch submission, thanks!

Paolo


