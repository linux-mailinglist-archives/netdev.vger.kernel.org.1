Return-Path: <netdev+bounces-191508-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF4BABBAED
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 12:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D71B3A93AC
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 10:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 605AE26E161;
	Mon, 19 May 2025 10:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dqc5x+bW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E772749F3
	for <netdev@vger.kernel.org>; Mon, 19 May 2025 10:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747649975; cv=none; b=K5Cx8KcP2/rsDAIBdiIivo1LLy67SdEqhZb5XR01ojsZdOYiZlKq4bhdAyOyQPys81bGr+o9HyeqnIVnwVZglMitGnhStPAmIkhIdmiawMe7m4c8+Zf0fGYUsHDzlMa7YhxijDD9S2WzCwtMxwHO3JJBhMykHKVl+iMzIiXg6M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747649975; c=relaxed/simple;
	bh=kNmUELyreMRY6vFE2o+tqx49/k8safWejlM/mSxoX0Q=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=DcOQGVGzVItubrd1iLoY83caLL/P7vnBnSac/aPGZqDzBEthomFZRmMGUXqNpAjNrPkQ3Jmg5GLbLyxgKHcoXqOsFa/VUA9OTXZcUxXyRoCpKvMtOFVaBTNj9OXyNVxXDfUatb3lpkAq7moQ5qMMujs2KhSqyrRK55QVO16TkdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dqc5x+bW; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-442ec3ce724so34326685e9.0
        for <netdev@vger.kernel.org>; Mon, 19 May 2025 03:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747649972; x=1748254772; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kNmUELyreMRY6vFE2o+tqx49/k8safWejlM/mSxoX0Q=;
        b=Dqc5x+bWefUXW94q/KcNUzZK+/X0cuGtP56vanEsGoyLBjKYaeDuF+AH6HupoVWmgz
         vy7CDnSSr/hlepemjgZy5EeCH4RsdrvXfpLGWmGvtdqYudSQ07tnQfORaxKEAlU27rZY
         OQEU/Dtx7Sc9XsNOcH1BJlX4+1mPHZp9xn/1boV3mCUxIEB9OuWEj9kTWidiZ6bLBef5
         M7A0j+w++TeCo5987rz7az1T71YKM3Ak1s0b9WBGvca3ze9BHyd20gN8l0qP1nldZSDD
         DhgQN6D1rddkF1BRYnGF1DYMWRrSgdtgLX3mzjmFSXzVhB8CwdiOpuT+gCa3gdUW45XP
         R4JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747649972; x=1748254772;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kNmUELyreMRY6vFE2o+tqx49/k8safWejlM/mSxoX0Q=;
        b=Fy+/Ir6UJ//3UPutsuiFXD0IVdoqc9EzbTQl5tPadUF+a0JahCK7ouyWXgu5mpb7Yj
         uGuLXQ5iBuOosWG8Rk34Qumz7EAzMxSZIzTIbWal+FtyH0Ev4f1avBteRIAfSFPSii57
         mSk8fpIqZ46xRnrBn2RUx0iCYtiJ0Luz1WGKkvUX8KUM3E0YqfBhJ/ckgv4SUk1rCIWT
         kiIe+a15FdVhT9pN7ucoYhVaQ6F91Z2sHYyfk0UDdIH60nP9EFEifRd9fv3Mv4GrzQla
         iY/hrJtryuo2YLH7i9W58IjbK7V9Qz7ZgRsGeILeBiJ5aTbn2DCl/HnI3gZvg4MnDd5j
         Q2iQ==
X-Forwarded-Encrypted: i=1; AJvYcCX66TlCISK6Dd2IJmZoIDbySgPZ+/8OBn7gdRLEbDgL5teX5YTgUAEZkEgfS4y6EEwuyxIiy84=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWktg4VAwX42LW/931TD2y7IMr6/8ugZaJz1WpKMiL81Nw0oxY
	OqYfVoRpDYXAhZ+pegm8kokGNt40AWVGQKbwAXUblOdpas2iQnZg7MsS
X-Gm-Gg: ASbGncss5DjUw3S/kLRLZyo1RI1ux7XBdtEBNu4RLwsh2CpRbR2+U6ARc7vlvzmH1QH
	YS34lkcn9fZM6aDfrUBHLf0axEvL3jGXSX+BNsqFeUjd6Mh3Wfu+Ty6pMl/RVYugEr3cDNmHSwS
	TqwK3oeZw2BT6INFBbN7E9jcXxHHQuBDDuhQaejqWUYPBybdiF5RnTWvP8q4iphJ1eWsVjqDSAo
	RsJrWzSNf7F+C860gHwhvizGPLIoXiTuOlaXtI1fcdHMy1/nsPCiYPnp37zYG/BcuqIqWGF/aYF
	fkk8I1PH4yveyQRpOzcUDk8E63z641rfAjdP8sVYaTCcWG+gd8zgZuX+tGPoJxCy
X-Google-Smtp-Source: AGHT+IGp+/ysK96iYPW0uLbzv55vkq696vdPDC5Lvxbx4G53bXXiZt4GGiyF/VMwIgMdZnFn4R7voA==
X-Received: by 2002:a05:6000:1a85:b0:3a3:4ba9:67cc with SMTP id ffacd0b85a97d-3a35c825f6dmr11864227f8f.33.1747649971844;
        Mon, 19 May 2025 03:19:31 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:d5e9:e348:9b63:abf5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca6294bsm12466312f8f.51.2025.05.19.03.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 03:19:31 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org,
  jacob.e.keller@intel.com,  sdf@fomichev.me,  jstancek@redhat.com
Subject: Re: [PATCH net-next 07/11] tools: ynl-gen: support local attrs in
 _multi_parse
In-Reply-To: <20250517001318.285800-8-kuba@kernel.org> (Jakub Kicinski's
	message of "Fri, 16 May 2025 17:13:14 -0700")
Date: Sun, 18 May 2025 14:50:38 +0100
Message-ID: <m2jz6ejadt.fsf@gmail.com>
References: <20250517001318.285800-1-kuba@kernel.org>
	<20250517001318.285800-8-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> The _multi_parse() helper calls the _attr_get() method of each attr,
> but it only respects what code the helper wants to emit, not what
> local variables it needs. Local variables will soon be needed,
> support them.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

