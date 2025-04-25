Return-Path: <netdev+bounces-186703-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8840AA0738
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 11:29:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7E4617988A
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 09:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA00D29DB79;
	Tue, 29 Apr 2025 09:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a9xLxY+s"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0222C108A
	for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 09:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745918850; cv=none; b=Hkc4XVJQc3ic5tGjJqULsjJq5ileWPMpVd8kIQypGvkpbR1Z+KsBx/MSRHYx4aV4F537QAWOhQQKhNRPVTdu9tuLx4MOjBSajBGjHEEXc+Sz8f5ab7xY8j6OE1+34L+4XVmr1y1CSkVUwQNLfSHeMY1T/L6QDE75paPKde2+MzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745918850; c=relaxed/simple;
	bh=uFetF7HIuuk5O7al0uyhysHtL5Qou7gLbjJ3mo69BRA=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=GJkIb8pM2MZoUtoXpQEgmwNhzMZyMSYj+2jP7cHwJZ0JDNtmABPRxbXEAGPdVmrzQE2RrNgJ4Trcwdn9CkEVJENSod4Lga5MuScCo97UCtjUM+i804OUtVpRI/w+eoK2v1/bG31SYuEr86vczevXFPm3HDtkCysjZdUFSsrJzJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a9xLxY+s; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-39c13fa05ebso3771986f8f.0
        for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 02:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745918847; x=1746523647; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uFetF7HIuuk5O7al0uyhysHtL5Qou7gLbjJ3mo69BRA=;
        b=a9xLxY+sFzgim2XiaDVrqUHkmiwA9vndgAH7w7iicM2Ajt/vOH+vpI3ap03lXYnXJQ
         gpAFrhVnXOzwqyN1f7tUTy81o0n7SAqqpyRVn7WICG7you9A+qOu6Q8h/y/13KTuDLD5
         nqoDbH7IZkzV3CEHpzidmkY27jYw01Y2BiO31D6WGUsxK3zEmW/BV+l5Rvuzh+mwpk5f
         fsmLelc8Fyog9vW3LJIS2nyZ1BJR4BzXLzlFJeapOydbP8TiflntfDOqtfJVAjgW3bC3
         86DNC8LGdhEyLl+vr1DW9Zzy8k50wIsAgQdZnKLhvcKcXmI64iEAdR7ZloOe8lXSvIak
         /2Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745918847; x=1746523647;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uFetF7HIuuk5O7al0uyhysHtL5Qou7gLbjJ3mo69BRA=;
        b=hCssQ5kg8tJI0GQeGfIcLFVAFHdZxOJGrjtd0MS7PCZomSLL0EdS9tALEH/yY/7O53
         GQa2lCggCVvyBfo9+LkajXFGJi5+27U6Z4/DwaUmkAm/NmnDZ1Cc3BABEClJ5ziNvtNU
         eeu50gpDPigHv+5MaalA1Iuf9ormMgcUQINCFNC9wpLvcl6aPeIxxy/bSS80TUdJqQuw
         ZEXlrqk2GR1LrbPejN36dzzIRIOjfeL3J3oMcWHjiM/Utz1gCB4BiMs0E21SN6vfLvRi
         OUi+TmAcE2o5bvzPbooWaYTlKGW03dzTorRuRP4BVkDSudPVT3XE+aevoJXXeDuzWIVz
         MA6A==
X-Forwarded-Encrypted: i=1; AJvYcCXwKQHWNk/Gxxgax4yT8svoUP/DTdlZsFb56AWzIouZGv2vgvwD+eOhO03dwUvZFy47YQ/Me0M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLDRsm4EPoHRE/f1UpFU4wz4JEIrbWGHhurxDHNDHt7IQYU1Q6
	Xoqbq52nIgwG5I4aqLDbliY6VYLja4FBfIfGBw6iGmwLjlE20izl
X-Gm-Gg: ASbGncsJ9Id/AIl2KcJqiYHgALJQ8k3epfmg31BlGkDlFveuzw26S4A3Jik8P3HC2xB
	gIYQChHQ7Qx0Y4ZInxAQTFZux7MDYa2xYAZFnH5OqUiIRO1vaAIdbIIVUjBFxF7eKXkqFTANDHi
	hrDAg4xKAYbCeRLlGz4tCrDgzryL1soSrPJLG+QC+NeCaaesdNQvyc0BVVIIs0JH8HmNaUjCbaW
	OxBPuJPfx6hlrMFYWy58acw63vfptOctcx0+V3IiI38z9gEKxC/Si3x4BpxkRXP1TVya0tofbod
	WlJivdFKuooML3GBsr5D1HGmyqeiUCQ2JKG5Ggp2A8fnaHc52eOCrA==
X-Google-Smtp-Source: AGHT+IEbCzjiBvFCGxRB3qYcxfi6wqq7nct/u5+KZWNuu0wE6usYtZb06aFgyS2cVD6scrr7CpaKFQ==
X-Received: by 2002:a5d:5f44:0:b0:39a:ca0c:fb0c with SMTP id ffacd0b85a97d-3a07aa7594amr9032917f8f.28.1745918847334;
        Tue, 29 Apr 2025 02:27:27 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:251e:25a2:6a2b:eaaa])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a073ca497esm13307273f8f.24.2025.04.29.02.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 02:27:26 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org,
  jacob.e.keller@intel.com,  sdf@fomichev.me,  jdamato@fastly.com
Subject: Re: [PATCH net-next v2 07/12] tools: ynl-gen: multi-attr: type gen
 for string
In-Reply-To: <20250425024311.1589323-8-kuba@kernel.org> (Jakub Kicinski's
	message of "Thu, 24 Apr 2025 19:43:06 -0700")
Date: Fri, 25 Apr 2025 10:26:01 +0100
Message-ID: <m2ldror3rq.fsf@gmail.com>
References: <20250425024311.1589323-1-kuba@kernel.org>
	<20250425024311.1589323-8-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> Add support for multi attr strings (needed for link alt_names).
> We record the length individual strings in a len member, to do
> the same for multi-attr create a struct ynl_string in ynl.h
> and use it as a layer holding both the string and its length.
> Since strings may be arbitrary length dynamically allocate each
> individual one.
>
> Adjust arg_member and struct member to avoid spacing the double
> pointers to get "type **name;" rather than "type * *name;"
>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

