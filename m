Return-Path: <netdev+bounces-183210-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A1D2A8B695
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 12:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90AC9442E45
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 10:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F46238C10;
	Wed, 16 Apr 2025 10:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KGeF9fPD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955D4238143
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 10:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744798683; cv=none; b=BrVZzkllEu1ibDP9du+z0Sscf6bbQBesEvJ6pa23+h9UicZQb/5ZwxXSTmaPOqP2nRnwW1tssbVjq6oGzUflJp0Wqhad8YbUZoAxZ8uDtwvWzGxEEuuwLmxwMV3IqRTIZQ3o2f/LGLSQwDzPe80bXEMpyaT2WpU+DXYN49AillA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744798683; c=relaxed/simple;
	bh=C1k2/gZ40S7BcZysMnJymxOOvTPVUIB1dnYGNJX/9JE=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=QC/OaB4JV4t2ghCESjx0P/GeGhFXGwyU3HASX33L7tl9Nz2U75kkCvdg/SKQAYn5OuQ706sEJ3vNGDCgKJrTljHQKa2w1Q7CiUfcm2LTy4s7wX2UVvA+X9NXllG9+nlWjqveDS9V7DqRrt0ahiiRW9iN9cGo3+3fNap8EJseNKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KGeF9fPD; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3913b539aabso3988668f8f.2
        for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 03:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744798680; x=1745403480; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C1k2/gZ40S7BcZysMnJymxOOvTPVUIB1dnYGNJX/9JE=;
        b=KGeF9fPDGspKhVCH3M7gcYqzLebN+SZGnUI8YVDEbDGjNDUpU7XpRgXq/CBYIFTnkK
         DyOq7YLmMTjkgm//zMTS/15p7L0wkBW0COsdrJ5d04VflnzBQc/jelscRcDVDcwXG8mu
         DZ6ucscMg3A7i9H53J3XMfNer71AjB5TO2c1M9oYN4jhHu+m4Yt1CsWk+sRO1kBL+Zv+
         PN0zQwtj7eXqXQqfEeOUoHkhBA9v3xlnhBS/Sf4AnU3COqrj8d3KK+tE5AzN88KwN6RE
         W9JAKqG1e9urdK8k+o5NPqWDqek37VF3xpMMWm51x6I7kc2zc3E6Zgy/R5/MGaqkz/ej
         YHSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744798680; x=1745403480;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C1k2/gZ40S7BcZysMnJymxOOvTPVUIB1dnYGNJX/9JE=;
        b=lrP4ukD6YSwfISZYXOdBPRiiBrjueSlAKLQmHS8huNnKqa7ooLrSuj0BZTa44pfHDp
         gZQoKdyP2uvHDKB7LujORpmaR0RwqQgdLeCOycLI5SuyfRy92zXh/MFyOx4p3QbBeSoK
         lD+rXoQmnnnaUeX0oEhnziKfd3KOPwlEgmGRZYNfYWzWfApqnirTYqdnpA5HV9EthEez
         SkCoqjuqKt60hWAZeEiFhkTueXkVmAfNCmMEPJAtxuo9jM7hgN0NbGRdDI7+B9ZVuCxU
         9xFxC1VPMfRhGSsgxDQkE05E4d2NQEur8vNKpRRqqLrVpcvCmK0sz92e6FMqUyVk3DP8
         lyQA==
X-Forwarded-Encrypted: i=1; AJvYcCUth5RY+sZhKhL3b6c3yQ2jJwF+jeGRAuQG/HBneH4jSQJc+PA/IzODZilEdOUJ/UoWcQl7vOk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1jBXUim4l+jDIUm3Sy+CtgS51SrEryZsEhPvJl/5VBcmowaxa
	lrNgM7EaZ0c3tr1UA6FYh2Ji0Fr0Z+AaBS2YWzp4j3sn7iMGsSbNJWPYyw==
X-Gm-Gg: ASbGncsq+JF+cKQhIJB1gsXqYJLc1pags6btvQXRhErxZv2KsZ4mZUvnuWq52xSI4AH
	mfGx4NKKpJiyJXWqNTJTMddKuaaR2MqtlD2oJ/BQ8+tZvetuf0EsdfqMMcJI/xwqu5tS336AUHL
	T5pTPeuAtqTuG1raU7Jd86PfdfOfKmR1T9SLMjDdBtgDNx2qVwI8PVmIHxRrE7eO4HMsBIebCL7
	Mf3Tw6DiYugxbUd5vVWg6TYtRmZEfPgkjMaq4HXYGfbEe7yeTOFZUx+ykJMu4hKQA9oewK2IHza
	hwRxrTDrWsc6pEWT3LcjgLN43yn57xG3T1akvo8dqiU6Z783gxwT4F2qPQ==
X-Google-Smtp-Source: AGHT+IGZpQCu9mlpcO0YEMH+gk4snM0zm7eVUbrYizcPlIpgM5Fo9VkDDO0yx8ow0Vw4gxxAiy/nSQ==
X-Received: by 2002:a5d:64c8:0:b0:391:43cb:43fa with SMTP id ffacd0b85a97d-39ee5badbdemr1282580f8f.51.1744798679499;
        Wed, 16 Apr 2025 03:17:59 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:e94a:d61b:162d:e77])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eae96c074sm16351396f8f.28.2025.04.16.03.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 03:17:58 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org,
  daniel@iogearbox.net,  sdf@fomichev.me,  jacob.e.keller@intel.com
Subject: Re: [PATCH net 2/8] tools: ynl-gen: move local vars after the
 opening bracket
In-Reply-To: <20250414211851.602096-3-kuba@kernel.org> (Jakub Kicinski's
	message of "Mon, 14 Apr 2025 14:18:45 -0700")
Date: Wed, 16 Apr 2025 10:56:15 +0100
Message-ID: <m27c3kmnuo.fsf@gmail.com>
References: <20250414211851.602096-1-kuba@kernel.org>
	<20250414211851.602096-3-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> The "function writing helper" tries to put local variables
> between prototype and the opening bracket. Clearly wrong,
> but up until now nothing actually uses it to write local
> vars so it wasn't noticed.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

