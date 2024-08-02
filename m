Return-Path: <netdev+bounces-115315-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F43D945D1C
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 13:20:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05A311F21A40
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 11:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F1B41E210A;
	Fri,  2 Aug 2024 11:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="vvVzIzbV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6DE01DF66B
	for <netdev@vger.kernel.org>; Fri,  2 Aug 2024 11:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722597604; cv=none; b=d0IO38q7JRdDryrDQaAcMMfI6hQT9fvmKcC6DiDHSK4FZVXp2cepVxjqptpzEBYqtNhClnuQqlkaF+Rxj6aHuJ0f7abA05xEk5zPXse0T0S5fQNVddWoytHsehmBX/QMv7cSqvPBO94MsEsifjXG7ljlgbW3a4/VLXY6jRhE+4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722597604; c=relaxed/simple;
	bh=k9HyMzf4EzzZUVqnHBrs5Y3Cu2N6XjIRBhtcBznNbcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tZL0OCtjE6AA0Einb2RmdeG6Mt98KKhFZCbz32gC1F7Zjd0DitutkLFMUIF85xQAuwlmJvLbmWEGVrTvPz4ym7LWE8GXlamiFCGGm8ccRhC+vXnuZB5v8tVxv6Rt+AGYlfLdAFESpDNeaK4oj8In5GOFl82aHOA1eHmi/PSickU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=vvVzIzbV; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5a10835487fso11164815a12.1
        for <netdev@vger.kernel.org>; Fri, 02 Aug 2024 04:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1722597600; x=1723202400; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UCRGPHH39h/JyZAxINtlp6O+Adb+Rq0MmzUnC+3zzG4=;
        b=vvVzIzbVH4rHwLUkqdn40q140/7PtLy8Op+8UAQZTZTJBqm3ZYAI9H3ANM9oU7Aj4O
         LrMOW/yGJnzypCc4yb4Bc2Q8ErQHvfglzvMQj0kDPEb+oAaxpxfGvlKmDdJdtPRraMn1
         CrJ+EEOuxG4X2ZkM8W/nKW1QTQ5o7Q51CPUj/JxMjEQTZadQgH+HloZbMGfjgM6viuqh
         LiQY5h3V+hCEl8sT9FUPHG73E7cUg1wIwoDrxjxacipLDCUkbrhHfxBpnbIf5Q1vvvYP
         Eu1BlcN0jUi/U5RdN2U6RYJf8lKtB5dTgSVPrZdJx80S4trviuGcBvgmjUtYysggHq7M
         GaKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722597600; x=1723202400;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UCRGPHH39h/JyZAxINtlp6O+Adb+Rq0MmzUnC+3zzG4=;
        b=diL86ykw2goO7TIkQ2xgLCGJ4X8ZGJKj9t61r/saGyY5/t8/UBG2loYbXhXv5Bcxut
         Za4T4kyNjAeJ0AKUEWCd2K4p6aFNqweri7OkJFb8j8MSLsasc7q/0F7WqMjldsUsEJLS
         pX8RPUZDY8HzFHPDLu11kkJ97Q9LYGBVXhnAUl7q3kuTdPkabWfGMIRrYdpHxYXLLJgm
         GZjjsysOOn7YuQqBwj/hcRewUCfHQub84R2X6zE9S3mKkFwrxiXFXFg5HxX7txJJgzbc
         CG3aDUb2UgJyHc5DF8Vf7SFnQ6pEydw9PjbLemb4wTu5vwB+wi2hchuIwo79p/yYBbom
         LEgg==
X-Gm-Message-State: AOJu0YxQodctBoFCGGvhPsg/HcFBTMcj4TK9rBWpa8QTN0YxMTQiOEPO
	/A1PIwZwii7rS3cJyNUAukWu0c0p3XhlA/skzcr/d1J53rWchJ/VnkTQxdpzu6omsv6AGg/n409
	m
X-Google-Smtp-Source: AGHT+IGkAIZpv5vH7VaAdNLDJwW8A6UG7uIM6pNVAqK1i5EpJ0FJZAXQzjw/wfPIS325tA+XLQvigA==
X-Received: by 2002:a05:6402:2032:b0:5a3:a4d7:caf5 with SMTP id 4fb4d7f45d1cf-5b7f5dc13cemr2006341a12.36.1722597599877;
        Fri, 02 Aug 2024 04:19:59 -0700 (PDT)
Received: from localhost (37-48-50-18.nat.epc.tmcz.cz. [37.48.50.18])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5b83c22db71sm967763a12.94.2024.08.02.04.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 04:19:59 -0700 (PDT)
Date: Fri, 2 Aug 2024 13:19:58 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Madhu Chittim <madhu.chittim@intel.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Simon Horman <horms@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: Re: [PATCH v3 02/12] netlink: spec: add shaper YAML spec
Message-ID: <ZqzA3rbIJmGjzIlU@nanopsycho.orion>
References: <cover.1722357745.git.pabeni@redhat.com>
 <13747e9505c47d88c22a12a372ea94755c6ba3b2.1722357745.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13747e9505c47d88c22a12a372ea94755c6ba3b2.1722357745.git.pabeni@redhat.com>

Tue, Jul 30, 2024 at 10:39:45PM CEST, pabeni@redhat.com wrote:

[...]


>+      -
>+        name: inputs
>+        type: nest
>+        multi-attr: true
>+        nested-attributes: ns-info

Hmm, you sometimes use this "ns-" prefix. Why? Does it mean
"net-shaper"?

This results to:
net_shaper_ns_info_nl_policy

Wouldn't it be better to name it just "info":
net_shaper_info_nl_policy

And for ns-output-info, just "output-info":
net_shaper_output_info_nl_policy

?


>+        doc: |
>+           Describes a set of inputs shapers for a @group operation
>+      -
>+        name: output
>+        type: nest
>+        nested-attributes: ns-output-info
>+        doc: |
>+           Describes the output shaper for a @group operation
>+           Differently from @inputs and @shaper allow specifying
>+           the shaper parent handle, too.
>+
>+      -
>+        name: shaper
>+        type: nest
>+        nested-attributes: ns-info
>+        doc: |
>+           Describes a single shaper for a @set operation
>+  -
>+    name: handle
>+    subset-of: net-shaper
>+    attributes:
>+      -
>+        name: scope
>+      -
>+        name: id
>+  -
>+    name: ns-info
>+    subset-of: net-shaper
>+    attributes:
>+      -
>+        name: handle
>+      -
>+        name: metric
>+      -
>+        name: bw-min
>+      -
>+        name: bw-max
>+      -
>+        name: burst
>+      -
>+        name: priority
>+      -
>+        name: weight
>+  -
>+    name: ns-output-info
>+    subset-of: net-shaper
>+    attributes:
>+      -
>+        name: parent
>+      -
>+        name: handle
>+      -
>+        name: metric
>+      -
>+        name: bw-min
>+      -
>+        name: bw-max
>+      -
>+        name: burst
>+      -
>+        name: priority
>+      -
>+        name: weight
>+

[...]

