Return-Path: <netdev+bounces-78303-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 617F3874A6C
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 10:12:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DA9F2817E3
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 09:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC41823BF;
	Thu,  7 Mar 2024 09:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cQmGF5ZA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5400D82D8A
	for <netdev@vger.kernel.org>; Thu,  7 Mar 2024 09:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709802739; cv=none; b=io8lRo6fl6SCXXAYqGgEDMiNPgymgGdfoUkXPn8sHK95Qws6+Vp0qnZ7yjQCrMCmdOGMazD/RowIkIVpNELpxOdGvNso/AJvZBeSABZ4ULbMK23JqdbN4tGva1lU78PxssXoz4hyp3kIjJhV3ItcYLCb7EBqEnml71BJRhq/1As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709802739; c=relaxed/simple;
	bh=9zcxcj/+/jwqDoQZFZMZGlm89mLjcAulqrwjQvaSNDc=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=gDQb5YGPc1X9NEv+sVw4h9ZZUZYfhxuypWSuXTV/IEU2Jezn12Wkiu67YUw3A384eoYr2wvLZcbaKFvOZ/a+c6jAfanqFkRErNm1ejfjL0czeVDDX7MA7ySxZXao/88WxaoWQdzmS2AFCoNNbQQUYlUtvoFT+ss9Pksu0bzqR1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cQmGF5ZA; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-33e162b1b71so598874f8f.1
        for <netdev@vger.kernel.org>; Thu, 07 Mar 2024 01:12:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709802736; x=1710407536; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9zcxcj/+/jwqDoQZFZMZGlm89mLjcAulqrwjQvaSNDc=;
        b=cQmGF5ZAgSipzFlLce8gpH8qsbn/UorXd0LrtTTrmjI2KzPZHB4kAP7Hi+KCfBtdrl
         IZk29LSsthSGHaX0bXbz7mg3UPJmwlo+uoerhSItzhUD1+EnB3bFY5D8qQfEkzvL/N5f
         6npXGoZJ8sI+i6lnJw/cW/FKhAM8LUJ9zH3/RB3Kpg0gNu0vjt7kjx234C15VDkrSCXA
         7LuE58EezYoTBjuOW+H+o/fpxwuZdSo1Km3NV+AVbHKG8RZrmZ5Xe3Y0+RgzMPBrhj1x
         Ni1hlR/cs2+0HV53R8mghlwuauBO0kNTgZITgSlRTYelNvfE8RxfsagRxlqNnNlblP6y
         EsTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709802736; x=1710407536;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9zcxcj/+/jwqDoQZFZMZGlm89mLjcAulqrwjQvaSNDc=;
        b=alg6T0hJsaXJZLTfWXu4WyKuG9vG1S5Uq+1PYu2bAMk/hRKtMpIuZ1NeHzImA6jfWV
         ZlVN8Wgz+9hccQqvXtCHOrAxoHshJ18ev/GZinVU2AXLt/2CahxTeqvqaH7tGEjGFjQo
         8+kleaCJOJPrlAVPYm4k6HSnA132161Pj64drtAj3ZbmKnbgIaBfTVIJgaC1XV1RVyBQ
         CJUpowz47fkdxfDgNJwPSKJvgwGsBS0aJKemRKkz/2HrWHuYrIMmj4l/zZbwBgbKFUEg
         nTjg1mKrFbA43lX//pAZdn+wNx6Yf/+O8fGTdZxCq+J51Hlx7ZV8RjPJvvyVu5GVjafz
         Dg6w==
X-Forwarded-Encrypted: i=1; AJvYcCUt1K2eh+fJ/wW/da00Bvj3BvoiNNlHDkOmNtlTvRWXeO+fyLre5t6RW19n6OeUura7gsmKlgH/xhXVRe8UscNHZZlJ3GjH
X-Gm-Message-State: AOJu0YwQ2n/2loR4EELW0XszKupbw/XdnrVJHtx1fNt7US7phlNOn3CA
	frOcHJu8Op/Gwp54oFsvADKH/nbC5oaP4oCiVKZyU6YAuUS6eZd0
X-Google-Smtp-Source: AGHT+IEeUtPhPpaYn/k3jYckLGzfpuVIh4xBKZkl31XhGE0iOPR1urnbeh+gOFy08yh7xx720hE7+A==
X-Received: by 2002:adf:9c86:0:b0:33d:731f:b750 with SMTP id d6-20020adf9c86000000b0033d731fb750mr11284153wre.54.1709802736298;
        Thu, 07 Mar 2024 01:12:16 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:952f:caa6:b9c0:b4d8])
        by smtp.gmail.com with ESMTPSA id by1-20020a056000098100b0033e22341942sm17014282wrb.78.2024.03.07.01.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 01:12:15 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  nicolas.dichtel@6wind.com,  jiri@resnulli.us
Subject: Re: [PATCH net-next] tools: ynl: check for overflow of constructed
 messages
In-Reply-To: <20240305185000.964773-1-kuba@kernel.org> (Jakub Kicinski's
	message of "Tue, 5 Mar 2024 10:50:00 -0800")
Date: Wed, 06 Mar 2024 12:31:12 +0000
Message-ID: <m2jzmfh78v.fsf@gmail.com>
References: <20240305185000.964773-1-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> Donald points out that we don't check for overflows.
> Stash the length of the message on nlmsg_pid (nlmsg_seq would
> do as well). This allows the attribute helpers to remain
> self-contained (no extra arguments). Also let the put
> helpers continue to return nothing. The error is checked
> only in (newly introduced) ynl_msg_end().
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

