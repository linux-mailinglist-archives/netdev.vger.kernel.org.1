Return-Path: <netdev+bounces-74504-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D248618A0
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 18:01:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECC861F25AF8
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 17:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFAD11292F7;
	Fri, 23 Feb 2024 17:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q70nIhlz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA0A28DBD
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 17:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708707662; cv=none; b=QWCz9wLIeKP6bbIsWIBwaxtEDIiG7NwKHf7jQhUXT/X/1fdXjB5UgeeFkJ/sSodlfsfFnlaSdd1h7WVnIfw0nmDiGg021bhw4WegiN07f6SAfzkce03/j6FUnxwbLgD43g5QYGpjmXPz+CZN/ElcuvDwq/8XNxyr9gIJBLebUcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708707662; c=relaxed/simple;
	bh=Qc/iS52i8KfjkLrVh7ztx/7BSHvTzdeIFnTKniI5F/o=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=FNnPkJhQxBm72N9Ui/3BQqrf6q6YA/Ps2umnk5rFLsND+oaLYj15eZt8u1Ajn1tL6jFyB3RfbVb5DfYSlE9DIW51qcHyLmX/pt9Ie/jiwqsTwIbLGemfyi06WF6Yu3oAVnA9DNW4pK/w63wB0PGTvJx5jeyto61pwYeNc/fjSTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q70nIhlz; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-412985ba473so1003665e9.3
        for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 09:01:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708707659; x=1709312459; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Qc/iS52i8KfjkLrVh7ztx/7BSHvTzdeIFnTKniI5F/o=;
        b=Q70nIhlzfD5opGowCTVFTCt7+B1UbWMbJcH+NMHWaUcrLWuEVF4dKYKF5PuclbbjSs
         PAqxLi8mZmZGuqlkY0MLsJp0zFG5uYedhFdh9PyaCENA/36rBBRKcEoIjRViPYmhAZZY
         YMcADJAWiwdP0mn0HZm6PtJlImEuojX9HmDTn1qwLYQhGyzXdjDL8fk5nbDGHg8P4d/e
         icWbQAQLzv5+jl3TuMlJJCrOM01rkR/XkAfD8/uLESU6ufxOPuz27hV7oeUNGnUu3b/X
         jLYVjaJIekCfPR4RMW1swVlmoubhX8xlVydUn9ORZ/UH7DkRGegV/2W6qO9+zGpBNRbl
         EqJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708707659; x=1709312459;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qc/iS52i8KfjkLrVh7ztx/7BSHvTzdeIFnTKniI5F/o=;
        b=F8tJQ6woEyQrjOa3trHlmaza7e3JNyPEzuVjdA1Gjtgo1A1q0LNbejaTt1FQkiWFI/
         O9WmaInRuJY2CZIrd6H4BDgp3iTMWjvUUzVmQEcgJdRR2Q4pK3WaQgzmgUdo+NnO+jcq
         gPE3F+SwywvD9tH7f+6j0A5vLebdVgbyhLMgO+pb7hEthtPn7nvYD7Qefik9Kp/nLCC8
         WSimLUo6RLwoxkzYE+6H8L49qiod8z7svajdNwhiVzMRFk6E9x8Ks+RSqCexOXDuaR+q
         +MLHzchAEoXOaBEZxsCOBIHJvp7eSEHy8ZC2BxJrpGGWwlcIxcuC5S9KcSNG0kH6Hgjd
         o3Xg==
X-Forwarded-Encrypted: i=1; AJvYcCXaqAv4DBNLRAVyM4VsqjdnqsuGiGa9a12U+6F8UrGwbMFoxygvyTZtzIUzzYYWcZuNcdaHKrImdete+5hcu5ZHrxqs+tqw
X-Gm-Message-State: AOJu0YzszCAWQU/5LA0ZVGp2VrK5vt0YivtqGHCROakfkJVLAKjdt8zH
	d0SCqMzaXoslKM/DYsucdbj7GIHsikkYiPV8/+nTsfuTVa/v3Xw+c6wBo8rcf+0=
X-Google-Smtp-Source: AGHT+IHmungVMM+5l/A3DGti9VYX/YpwwOsI5h4LJcdAF1YexNgfHkKydvU1CgYqW8AIqQoOAGGNYw==
X-Received: by 2002:a05:600c:474d:b0:412:93e2:4f8e with SMTP id w13-20020a05600c474d00b0041293e24f8emr349175wmo.12.1708707659276;
        Fri, 23 Feb 2024 09:00:59 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:e821:660f:9482:881c])
        by smtp.gmail.com with ESMTPSA id bw26-20020a0560001f9a00b0033dabeacab2sm2832917wrb.39.2024.02.23.09.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 09:00:58 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  jiri@resnulli.us,  sdf@google.com,
  nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next 01/15] tools: ynl: give up on libmnl for auto-ints
In-Reply-To: <20240222235614.180876-2-kuba@kernel.org> (Jakub Kicinski's
	message of "Thu, 22 Feb 2024 15:56:00 -0800")
Date: Fri, 23 Feb 2024 15:34:04 +0000
Message-ID: <m2jzmvnqj7.fsf@gmail.com>
References: <20240222235614.180876-1-kuba@kernel.org>
	<20240222235614.180876-2-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> The temporary auto-int helpers are not really correct.
> We can't treat signed and unsigned ints the same when
> determining whether we need full 8B. I realized this
> before sending the patch to add support in libmnl.
> Unfortunately, that patch has not been merged,
> so time to fix our local helpers. Use the mnl* name
> for now, subsequent patches will address that.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

