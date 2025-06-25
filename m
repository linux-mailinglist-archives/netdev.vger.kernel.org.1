Return-Path: <netdev+bounces-201035-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C29F0AE7E83
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 12:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB9A43A2548
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 10:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2552829B8EA;
	Wed, 25 Jun 2025 10:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iodhvdky"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7E129ACC6
	for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 10:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750845973; cv=none; b=NrO+eXbwx8uZUdEcCIOpdl+Zrmo3fP2O9TNN3FTOtRAgp9ZjqbvdvRT3kGc1o+bazAm99dngUFcJeBHbo61Yp+v53fV4ohE+lWYUWQlm1hdkrKbhyCmMEbEKh5tQoiWJ9ivQIQ/r/QEolnrSp72qLcEbHZ5ilpEQ4mngvO4PhwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750845973; c=relaxed/simple;
	bh=VZG+HhCEru8LHmxLADCgUghgBineLTUG3afYNeW2SQY=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=mJwsmIrpQGLaqXOcG2vmlqT+diPwl4S5QR3RvPUFxn0qXBJvwsePKH5iirGkQc5gARP8MNBtGM3k1jnwZAAKCm59dRurcxFLYzMYIdcHKE4BaCQwR65LBrBylznuvQiHgWY1wAWCedQHrTJLqOOCLlkVkO1N95bL+gmN4ys9YJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iodhvdky; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45363645a8eso11287195e9.1
        for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 03:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750845970; x=1751450770; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VZG+HhCEru8LHmxLADCgUghgBineLTUG3afYNeW2SQY=;
        b=IodhvdkyCMHST39CM0Ju2+CwDe6g/zg56+bZT+aeb4LFEEDUdHSPtQoVu7qKpCWJdH
         aj5RsAXPN7OhgpUx9rQGJBdsQZh42U7jSIylHgP9G5INGEwzy9wwkvBwGcFoMCDBwL7A
         Wwkk8zBdXC2jlX7zM6ggV/KhxXxHDIxMNLvTcdySLTgS3dyPcuutsThSmcdvaCtnROe5
         ZJ8oOkWNWgaUKMTa17rFupGME72fTFV/kTGN81lIejcY4zGNmEWmXk0r8mG2eIc8fmnP
         hzPoZYE8oRke37kxMSi3aJjUn4s/GIWrGX4mSy7vrOKxkvlLS8xGu4+xyutg9T6nBjtU
         EInQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750845970; x=1751450770;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VZG+HhCEru8LHmxLADCgUghgBineLTUG3afYNeW2SQY=;
        b=UGHj5q4jmWFlAR0uSGLbnX9RYgNlkh7DgbR8D8jmgLTAMFhoHtiXpbKZ57igPPCZLu
         croY0rqmtbG64jXik1Qbw6Va9Ezb4KXiUnn+58sdgrdRD6IcMF1HckW70HF92ZEm+Cue
         fSpRJYk2RDuWqqNrOJ1RYBEmtRT50Eba02eOA2fXOAerJduHFqQMJPI4lNAutOo0LmqI
         5ORjbkg8jeFB8AvGO+oRb1NlCNUV/4wYqcXk0s0yW87qSRqwnW7Y3TS4rsscyLV1tx1y
         t4GL4dHbTFKUtfRVSFMLb9lC6rgNTvhNuHc45avuxLG+9LB4i0hn6oo6HekhmIfazaCg
         eA8w==
X-Forwarded-Encrypted: i=1; AJvYcCUhueNKmtVV99m4TS9gv1reYYtJatgpmlN8h+0i+RrOuOcvsCMLN/gZ7iLjthKQNYU8EQAKDmI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFTksrAI1oAfbZM7U7oh7cq4M9ZMeqAw1wL1r1f8JGkUOwjZmK
	Cb2ni5FX/fBYDq6GLpOp7/RuhVqXG/tFBM7LEWj+IIBBgcq2zsGq0qwA
X-Gm-Gg: ASbGncuGXQmo8qUlZAqPNLeT3ua9cca+q32G4LWZxKk4TVZ2q6LlyVcfTtqH32jVTL7
	TckATTBZzjZJcqDYXnvoyJcToti5KUo/pA8ZdJPBh26jBq461ts++NMryrFy1Yw3t+Yi4RnxEXT
	SUMilDMK3iW8ASF8gjNNFht9agKF0e0LdwD/H4VuqFJTrQk8HKRYVRYloCma4k+hG5+D+foPuZ0
	huKIB5OqxYV5h8Y57+5IzGCl8XpQhJKKN5eU9Yul0538esg9cmQ7VQkemYDXYKFQ+SgCHSrG+KZ
	46r/97w8/nzv4JmfmeARIiS9QZhp5y6J4g3qGIY9d3iuMRDHKI8ZWYDvFr0+S2+iQyjCm/dw6lB
	H59KqWmQslA==
X-Google-Smtp-Source: AGHT+IGs5plC3UY7HE4+/36LrC0sJUDpYMvYnOZrhElUgBUzRBRWRdRtVJHMB19KoCBiZnceXgL+rA==
X-Received: by 2002:a05:600c:348f:b0:450:d00d:588b with SMTP id 5b1f17b1804b1-45381ac2563mr24619175e9.9.1750845969389;
        Wed, 25 Jun 2025 03:06:09 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:5882:5c8b:68ce:cd54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538233a8bbsm15568795e9.6.2025.06.25.03.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 03:06:08 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org,
  jiri@resnulli.us,  arkadiusz.kubalewski@intel.com,
  aleksandr.loktionov@intel.com,  michal.michalik@intel.com,
  vadim.fedorenko@linux.dev
Subject: Re: [PATCH net 04/10] netlink: specs: dpll: replace underscores
 with dashes in names
In-Reply-To: <20250624211002.3475021-5-kuba@kernel.org>
Date: Wed, 25 Jun 2025 10:52:03 +0100
Message-ID: <m2bjqccfng.fsf@gmail.com>
References: <20250624211002.3475021-1-kuba@kernel.org>
	<20250624211002.3475021-5-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> We're trying to add a strict regexp for the name format in the spec.
> Underscores will not be allowed, dashes should be used instead.
> This makes no difference to C (codegen, if used, replaces special
> chars in names) but it gives more uniform naming in Python.
>
> Fixes: 3badff3a25d8 ("dpll: spec: Add Netlink spec in YAML")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

