Return-Path: <netdev+bounces-144023-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 29DDF9C5260
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 10:48:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5EE28B22A27
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 09:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0E420DD74;
	Tue, 12 Nov 2024 09:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IOLYUtt9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1364620E329;
	Tue, 12 Nov 2024 09:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731404123; cv=none; b=t1OUDmLp48snFMq3ukgW44oV37qxhoXr5NC2ViwoqkGG0x/KpyeRX4Fs0ah6+pTV57kazY5/k8pzrB5QctOIWKwApAJq0WEX7aZ7Vbz08nDbgttL43Wok2ETDo/VT5gEgFGaSBt14gLulwhFmutixAZSdCne7Gz3Oxs3fB6il7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731404123; c=relaxed/simple;
	bh=vGPlqcSPU1Ljbo6MVJlNin87hJ6NVZcYBJCBN5t2cvw=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=RBemWSUJgAebJy5fNygTCXvOXaL3Nr/T6EK43bosGithike9B2X/lxSmDcimRm5fjJO9YS+y3LQ7UJ0XY8yehhIKz1kTqpRFSqPa5uq69j0grhqZR4Gl7qGgc4YAjUruUdAU3vHrVkix71Kjf6O3Mr7phGJbU4veJaGNiWKsWwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IOLYUtt9; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-539e7e73740so5040563e87.3;
        Tue, 12 Nov 2024 01:35:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731404120; x=1732008920; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ze8znBzx95/1mVbeSUuR2PwFDl3INI4uOBO4YGJc4h8=;
        b=IOLYUtt9cU1RWbP2zeeAoBSgMn/9lSE/Ieb0HFKSmHxFd6z8ald4PWY2SA+t15CPuM
         VcCv4roT9JCwvkyPl+8yShwLU6bdb3c/VeyfN0RaHlkBqkCjgHJdo5z0wKHWNza778Z3
         2+oQl2kSjtOAzvKqNeVp2xpVNnJsaYNo3WDGCeNJbs/H6SW6l+0UIN8i7xuCpl2QcEoM
         VszYbBFNN9ifQdI5RvaOrOOC4XpjusDrwpBKUF45/B90k+x3S9vn9W9AJjtnKVLG2y5U
         ezitR/xJcGzW01RrsqDf4cpRHHaFMiRq2w9ygqVZSGTTDmLsPVMxyR2GlEb+7Hp4Wqvq
         nb/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731404120; x=1732008920;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ze8znBzx95/1mVbeSUuR2PwFDl3INI4uOBO4YGJc4h8=;
        b=o9YOC4lnd2fy6bYrWpzzecihw/V14upXy8FZeYnvIJKOqkCI06wZb1sZnG6VX7xTsm
         2wrsrJy0RZbx6NVAtYcjz7j5vSs6O/wTew2HLhimWye+TW8lee2Se05ftkhV0oZ3cQJD
         5KO5B99PJaZ1m4mO/H+Pc/7h7lgNZsHj9EcA/s/cLOb7HQ1E3xq7GZj9UVmxF+nTVIyu
         c2llw6z+AVy//lAF9z95W/EhdAJ+LVwmOQSG+LW9qbUghApOUtLxqz/dL7W1R+adsDw1
         Cf+zCJdX1kDvjnpSqQ0iqcLiXrfm2AxMK6apB5xn939PQ03+L1Bt8k0SYdZ6EJWy/oY3
         PhPA==
X-Forwarded-Encrypted: i=1; AJvYcCWT41xB+9N9iBHmLnLWooHarm2OlEksFBzHum+f8t0Eui1P5DsZ69sJM0xDTSWcChU6rfYXzOFD@vger.kernel.org, AJvYcCWpu2W8BEvj02xpuJ8C6VZEqS8reeMK9gFWUcm2PlHT4ytlXaE+sW83uNn5qAhwKeD8UWc7R5hqxBRZarI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5YA0BHrJhyF/G/BPmkn/ZCNRZ62504cL8OjVbIYkjwI3xQGlq
	KvIVYQvo37+w0Q1h6tUj9yvLdoB6k00J66gQKkyRv4ce87GWg/7eZ/QS5g==
X-Google-Smtp-Source: AGHT+IEEwipBRRYM44kkvqb98L+jAuiJoiwiqXDsJ0QQclEcwHZVZq2c6ZQMj2haKU6x12FIyFifGA==
X-Received: by 2002:a05:6512:39ca:b0:53c:6999:1782 with SMTP id 2adb3069b0e04-53d9a42e0demr915826e87.37.1731404119558;
        Tue, 12 Nov 2024 01:35:19 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:a1ef:92f5:9114:b131])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432aa737721sm243242925e9.36.2024.11.12.01.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 01:35:19 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jan Stancek <jstancek@redhat.com>
Cc: kuba@kernel.org,  pabeni@redhat.com,  davem@davemloft.net,
  edumazet@google.com,  horms@kernel.org,  netdev@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] tools: ynl: extend CFLAGS to keep options from
 environment
In-Reply-To: <265b2d5d3a6d4721a161219f081058ed47dc846a.1731399562.git.jstancek@redhat.com>
	(Jan Stancek's message of "Tue, 12 Nov 2024 09:21:33 +0100")
Date: Tue, 12 Nov 2024 09:35:07 +0000
Message-ID: <m2o72ku75g.fsf@gmail.com>
References: <cover.1731399562.git.jstancek@redhat.com>
	<265b2d5d3a6d4721a161219f081058ed47dc846a.1731399562.git.jstancek@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jan Stancek <jstancek@redhat.com> writes:

> Package build environments like Fedora rpmbuild introduced hardening
> options (e.g. -pie -Wl,-z,now) by passing a -spec option to CFLAGS
> and LDFLAGS.
>
> ynl Makefiles currently override CFLAGS but not LDFLAGS, which leads
> to a mismatch and build failure:
>         CC sample devlink
>   /usr/bin/ld: devlink.o: relocation R_X86_64_32 against symbol `ynl_devlink_family' can not be used when making a PIE object; recompile with -fPIE
>   /usr/bin/ld: failed to set dynamic section sizes: bad value
>   collect2: error: ld returned 1 exit status
>
> Extend CFLAGS to support hardening options set by build environment.
>
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> Acked-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

