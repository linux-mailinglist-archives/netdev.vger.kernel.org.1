Return-Path: <netdev+bounces-141935-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CBB39BCB6D
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 12:16:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6F8BB2155C
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 11:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 445EF1D4154;
	Tue,  5 Nov 2024 11:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RxvYQwVr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725051D278B
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 11:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730805352; cv=none; b=KXrb7CWsyMOFUzkAP5Z4TB3D0jgFd9a5G2wEPDi2PZcas2xNXsGeU8BszHdpxNuu6tvpgYAZnJAka5+j0+2h5OiqWTdHVyjZ7qHpCAFKAAkKspw/fR/TxI9i6o1nJsfEG1ImGWTEVVvaOBfZLmMFxuj8CdoqdWbPBdga2ceVjQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730805352; c=relaxed/simple;
	bh=e4RYtILrGg7x+u+04HSTlKO3X2JTr5oPu3XLnm44XVo=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=rDsEt3E1j96B+FQ1HWNBDCExRjXed2qz19OSPr4pVwDz8ePuX8CLHIdQHqhKcgCHtkgrfeB2ooI4a2EsKSp97pYdMSUuT8DMGRjZ6lGWfnU++WFWvj0RSS1dsmuE1SZQtBBh3UT6b2VXE1SHIdSjbU2cHsJnRPmodwuJQdoR50U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RxvYQwVr; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-539f7606199so2926693e87.0
        for <netdev@vger.kernel.org>; Tue, 05 Nov 2024 03:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730805348; x=1731410148; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XFj7XeY/jGruWSIPJbRMmIPh+AIbsqhyqVakLhosdHE=;
        b=RxvYQwVrvM72GL9tnNEd81Ee2HCO3iVWnBA/n46DBEdaGn1831yalf6ZiUNURB8doJ
         hqi5+bmrjCPlKW39iyrF5Hi1l24DSbVp7n/npu/0L5eikiPye8ZMU2Aki/ic2/PBr8JF
         8xnoq9+wm+p4LbDxjxDYW1VDu48JeKjHpU2hUW9bItYbT57sDrmXw+EoRmzKus0ovGf4
         w440xUFNGOD7r7h1Fe34zK53qF9To5hQIixFAcv4vQxfW0gUGiFwft3Y17LQI7sjIidH
         QJ317z8MgHAUNBZXgwtLq1xd/RW8p1hiGLiqKEXFSry+LURrJShLIKJ8BNR46eLvqAQa
         3NwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730805348; x=1731410148;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XFj7XeY/jGruWSIPJbRMmIPh+AIbsqhyqVakLhosdHE=;
        b=fL0WU03YJ5NZxCLFxLhWtSyNAM7UqjSAC6OEgfsMvRVc2kdaVjpCSGPyzEzQF3d9ss
         nKytzWt7n549B9TM2pq0wr3yvrmqUkz+FakkiACEjpO/f7aqs2HLHmWkll0grhekGFAg
         CRkR8d1WuI79ic2LyoYaJvkp+Qy+QaEX0jqi1xFiRcypzce9Os+5HS3ZA14+gKWjtAw1
         IwEy7h5Y9GNxalu+XOzAh+MmQNhrNR3qDy9ljlCiMZeI6k9fPkX4McW9IxYs1ZUKpmZC
         ElYieJHgaffeTloD66SSbceK40qnNjD6GjsWg7+zgOccYIGDS9/25kN+bkHEGbNDY9By
         LiwA==
X-Gm-Message-State: AOJu0YwZf8KwJszExesq7d2iPua3UXw19YRimLge5Gs/UgIsLJJnYjXr
	JwbvC2I96RZSZ30fe03dJDWm7h5kMeIjqlFYjY76Ez8ZdrXTiPhc
X-Google-Smtp-Source: AGHT+IEx1HQ6Sk8FdRkofzkMAMn2e18TOwCKR/uDaS/MNjjy2scfQVqvbV8Q7bka9Gh/+5aeHik32w==
X-Received: by 2002:a05:6512:31c5:b0:53b:1f7a:9bf8 with SMTP id 2adb3069b0e04-53b87674813mr12591251e87.55.1730805348213;
        Tue, 05 Nov 2024 03:15:48 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:e89b:101d:ffaa:c8dd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd9207d4sm211486805e9.20.2024.11.05.03.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 03:15:47 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: netdev@vger.kernel.org,  Jakub Kicinski <kuba@kernel.org>,  "David S.
 Miller" <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Paolo
 Abeni <pabeni@redhat.com>,  Simon Horman <horms@kernel.org>,
  donald.hunter@redhat.com
Subject: Re: [PATCH net-next v1 2/2] netlink: specs: Add a spec for FIB rule
 management
In-Reply-To: <ZykWTs9a3EqJ3nz5@mini-arch> (Stanislav Fomichev's message of
	"Mon, 4 Nov 2024 10:45:34 -0800")
Date: Tue, 05 Nov 2024 11:10:10 +0000
Message-ID: <m2y11yueb1.fsf@gmail.com>
References: <20241104165352.19696-1-donald.hunter@gmail.com>
	<20241104165352.19696-3-donald.hunter@gmail.com>
	<ZykWTs9a3EqJ3nz5@mini-arch>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Stanislav Fomichev <stfomichev@gmail.com> writes:

>> +    name: fib-rule-uid-range
>> +    type: struct
>> +    members:
>> +      -
>> +        name: start
>> +        type: u16
>> +      -
>> +        name: end
>> +        type: u16
>
> Should be u32?
>
> struct fib_rule_uid_range {
>         __u32           start;
>         __u32           end;
> };

Ah, well spotted. Looks like I didn't fix up a copy-paste from
fib-rule-port-range.

Thanks!

> Otherwise, both patches look good:
>
> Acked-by: Stanislav Fomichev <sdf@fomichev.me>

