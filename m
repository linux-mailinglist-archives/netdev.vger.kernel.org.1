Return-Path: <netdev+bounces-173907-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E783DA5C320
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 14:59:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3252D16EA6D
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 13:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA990255E37;
	Tue, 11 Mar 2025 13:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f9FMBLyn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDEC1CAA99;
	Tue, 11 Mar 2025 13:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741701560; cv=none; b=GBNHHOP8sElVys5JMoD+mobNd0WpSOgmPTHhIr/YaS7YawJdcXJt/hzHw1J5L6S49bawAnvXMGWlL4BzVMCKnwd2UbDRhLXGDc+G3nyjL5dBbjU+YNQN9gJjX8XkiJyMHXEfBXbGKkItw8ce2IeeEbrwTB/Xd7B7B4YvuKnJKek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741701560; c=relaxed/simple;
	bh=6TPutEDY5/JslEAN6w2UrpLwBfwVAK3JhPz1k2gBYOc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jtdZeptJpS/8Td8HYsnmlU+TF8MmA9pHOw9Cytn/Ou+fq823swEqYkqQ225q9D6DX88ogymex1XwtH+eUFUP9akMLZQJb7FZQsEDdtFztR0jlVdD6fvBDhKqPM/ervYMuc2NT1hGgd54r8TVgif0lig+LMosmliSe7CzcsCaLcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f9FMBLyn; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e60cab0f287so3798520276.0;
        Tue, 11 Mar 2025 06:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741701557; x=1742306357; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6TPutEDY5/JslEAN6w2UrpLwBfwVAK3JhPz1k2gBYOc=;
        b=f9FMBLynkNeyleQPxcHIqNV1QuYpl/jFAd0u4+Yyc5LGbYVjYxZ1Yi0cMeaOBEMGRV
         iXzOHiqt8+nCNFiKHwbEHiv1XrznOUvAgHQi4+96bvCd/KtnjL7uE2qBda0FSRoKC06m
         nE9f6GCvJLPq/RIIpusnaibTE+yY5mBo3rk1NXVgAlqAtDu0VlAyUdrHq/DmVPt55MZs
         665wnNDMzSQGxuRtCPHd29C09Rt1xQdempe320EkUgpvKqajDX1TFUfgkcjKqNolGbtR
         kpYIPZ8DpCUIV8WVNOmjhxiy8XpT+iRihKMv0Z5vaKt68i48gfHwddeYNsIvnzcBSVd8
         TCMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741701557; x=1742306357;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6TPutEDY5/JslEAN6w2UrpLwBfwVAK3JhPz1k2gBYOc=;
        b=cxsVGw3+CnR5pucftplhA0CVtVB1/L5dXPqIPP9gcEroAPjegOSXVnt9jyxefK9kdp
         QQGqYBYyUoWbVXs/xXly4SQrM/2qUY86tFOV4u/d/wmUtzKARSv/k7qW9inouBqpc8Xy
         kqMbdq9jipEMBk2a96tcn3W2NEBe9gdOZyqJ6arxVW2a7kdpp/GJGTP4gOdBaAqfnIeU
         k5bMEzARPuLCBazI2ub/pFfy5gAkYdlqfZ4Fbb5HfGkGuEBz0hLSfcCcD6c80bxzML0/
         bJxhtEVY98AXeOdYMlN1VJoVDzH/TifaFDBKm8OB4nkiRmEw4v7bHaTDy+n8dAaN3fxc
         ScTw==
X-Forwarded-Encrypted: i=1; AJvYcCVKnOH3rcJcCl4zrVA0ZnEpe0lnfC0MFTg1AYe5nqYADD9PwgBf1e2kc2ilWUvSoGR3y9RFw9HsJ86PYVk=@vger.kernel.org, AJvYcCWboE2zqwiUfo483Y1BoeNHMv6PG55/QkV9V2DzX6hLbc0lgEkt2ADAo0CuFDuZhCoDUyOXXBZX@vger.kernel.org
X-Gm-Message-State: AOJu0YxYPdmpHpLQo5pcNyBFK/9FMy/VU1ZZNgxrk0NbtF5pyn0owZQU
	JjNVv1S7ZIP/GJrE6/K2eKjQDiQ3PvsyYKqHpqXsz6yLsSLUsJ/KwXF1BGCWbCY9h+6v4Co2n9T
	SDsuJNf8cyz+BqDav4y1IR6YdQA==
X-Gm-Gg: ASbGncshJI2XcrawHPZQus0ZTc/pI//4dByqSHNnGf7xuEEyyz4JwB1OH2/byT0hp20
	9SspDZ+cedXZFngzVnN5XiyL+MBZQjHVlmeFvegUXM+teOz3LV5kTbERvuPA7raSG7+Ou0T/2oa
	OcFobivikW6SzjNtqiGbVHzJgkucilaDA+hvSnN1xYj+jCN+d0
X-Google-Smtp-Source: AGHT+IGexqqWtkaRJITDgVP9EokgAWNhuSIUAivJMC6kk/TKzd4mj2yTKdx7qYg89nkv2ZUyuBnSM2UEolm1xoh15Nk=
X-Received: by 2002:a25:1e87:0:b0:e63:6715:4d72 with SMTP id
 3f1490d57ef6-e63671551bdmr15330208276.42.1741701556980; Tue, 11 Mar 2025
 06:59:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250307110339.13788-1-rsalvaterra@gmail.com> <20250311135236.GO4159220@kernel.org>
In-Reply-To: <20250311135236.GO4159220@kernel.org>
From: Rui Salvaterra <rsalvaterra@gmail.com>
Date: Tue, 11 Mar 2025 13:59:05 +0000
X-Gm-Features: AQ5f1JpUhrNzqL1Z78LPHBKOjtJp_GHvT0Lon-k2I7-jKwfXudVJCvE4-I6Ac-s
Message-ID: <CALjTZvaknxOK4SmyC3_rN5eaCPqd7uvx52ODmDuAp=OeG0wxAA@mail.gmail.com>
Subject: Re: [PATCH] igc: enable HW VLAN insertion/stripping by default
To: Simon Horman <horms@kernel.org>
Cc: muhammad.husaini.zulkifli@intel.com, anthony.l.nguyen@intel.com, 
	przemyslaw.kitszel@intel.com, edumazet@google.com, kuba@kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi, Simon,

On Tue, 11 Mar 2025 at 13:52, Simon Horman <horms@kernel.org> wrote:
>
> Having looked over this I am also curious to know the answer to that question.
> This does seem to be the default for other Intel drivers (at least).

Well, r8169 also enables it, and RealTek controllers are used everywhere. :)

Kind regards,
Rui Salvaterra

