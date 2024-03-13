Return-Path: <netdev+bounces-79594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB00187A078
	for <lists+netdev@lfdr.de>; Wed, 13 Mar 2024 02:01:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AD641F2276F
	for <lists+netdev@lfdr.de>; Wed, 13 Mar 2024 01:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A78C8F4E;
	Wed, 13 Mar 2024 01:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="djrMq6cT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDCE6FCB
	for <netdev@vger.kernel.org>; Wed, 13 Mar 2024 01:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710291668; cv=none; b=uayB8+wROMWb+6Dtwv15uZIETNcWvs7NLbP/o/VOJ3bLWXAXzM49Pmhmb6y8Ulb0rCvcHOURg/LxVHsKsrxcbBa5zjhoyP5kjpyHQEp73vSAi/PQxyf9PJXcuKelTLW/iiKZA7vWfYml4VQFFTnm/u2LynqWgYec/X3DkL5XxkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710291668; c=relaxed/simple;
	bh=vod0Oteo/6Tbo55PLgkq1rrHpuWN6dhPTkJvDCvNrsY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NX22ys+pTj7Dj1Jw9iCnCIAS3d7GvEy68Yvg86A1laNC53xMWffGKAEXqZ0wi1PkrMKuBwr4ZlzN2XhbE6rmBsTUkRrO8H+YAjx37xbiAOTP2YuyJBzhf2nLprdQJUYNOvpGXn5dqxIZoQ2yioswWC1neF1K9lsOdzyGmXsrSbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=djrMq6cT; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a45cdb790dfso634563166b.3
        for <netdev@vger.kernel.org>; Tue, 12 Mar 2024 18:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1710291664; x=1710896464; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3T4oJ3T2wQraOYexFpJYePqHAPHXrr02cgINFeasfxE=;
        b=djrMq6cT5gh89sVB78d38f7yZeGiv1u2vydaViH+yKsZlDYJx9x3EM923Nkmm4BWVE
         OzmNIY83Y1zKmJquGqH1WZBMiDyDGWyjaveStKuQt/9qBkUey8T7jqr6NYzeiML3CgVj
         xu8yHxpC3oFby6nFDygfBMdWKmq/NxBJdMkxU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710291664; x=1710896464;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3T4oJ3T2wQraOYexFpJYePqHAPHXrr02cgINFeasfxE=;
        b=WFHFAjuhL9/NCIAf3L+bgnYUH1Aie0PNowA0r7XFYiXnAJl+x8K0mis7QdXhMkrnZG
         7hB2TyC+ztQTCT4dYKIpZqatoGsiVvA8mjm5GsQ0TtFLKs4fyj+GB7HwnaL/7H6NrerF
         Kqp/7VzngQPmPgllOpDsNOxkl9joEG/R7tWf1gMbZTpPvoRvBjMPMf/uFTloQ/3nl/OL
         MEKL/GhsuW2lxNgtzu2vge4nSS9SG0tnG0S7wJJCNMLw62WGrj1tquOJibPTYRJZmDIp
         +12BrqMaZJBuAf8n0+JggUl3bECRp3Hc3mXcqz6mLdnqIuKPVPq8anLxAPjLLTDn4oKp
         efDg==
X-Forwarded-Encrypted: i=1; AJvYcCWgaXCNJJFMUFnCUCl3vLq6KKR1IskSRL7PrjHr/HsEiYoZbwhW9afOy3J0aSuqKoQGQe8d5JNufEhmKFOwIb734iKtjN8j
X-Gm-Message-State: AOJu0YzNYMwGdAQn6JwC0AT+wrhITdsS6d6k8cjAU9YvO6kkW1Fwcqmb
	kUV2U3HMcytfDb7VZNumyrEYcZn4z0/N5aPprSJebJX65FwIId5rqnzL3hNT6ZXHNKPbQCeiFh1
	CvrnkIw==
X-Google-Smtp-Source: AGHT+IHfMAarhUjrH+j+QQRGgOxlpXv2/+F+ANBq7fiHGWbBosVS4eGA8CTbDKUd+Y3XEv/UvMl3Fw==
X-Received: by 2002:a17:907:1603:b0:a44:6e05:ea5 with SMTP id cw3-20020a170907160300b00a446e050ea5mr6809928ejd.1.1710291664375;
        Tue, 12 Mar 2024 18:01:04 -0700 (PDT)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id q24-20020a170906b29800b00a465e191e8fsm43426ejz.145.2024.03.12.18.01.03
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Mar 2024 18:01:03 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a4645485da6so175713866b.1
        for <netdev@vger.kernel.org>; Tue, 12 Mar 2024 18:01:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUBvL4Aw5qEODqeZx770JxDZ6TgSUzuuoyPFpodilprzsnQ/xK7/UAH57UJZbtYq6JvxvIv16YZpIixZJ+OVvGLVj7XyANI
X-Received: by 2002:a17:907:c247:b0:a45:5328:8432 with SMTP id
 tj7-20020a170907c24700b00a4553288432mr9215023ejc.50.1710291663582; Tue, 12
 Mar 2024 18:01:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240312042504.1835743-1-kuba@kernel.org>
In-Reply-To: <20240312042504.1835743-1-kuba@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 12 Mar 2024 18:00:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi0La3-L+WJ=vw7x7L=WYv0B_2YfeSuKD3YyCYJ6oAwKA@mail.gmail.com>
Message-ID: <CAHk-=wi0La3-L+WJ=vw7x7L=WYv0B_2YfeSuKD3YyCYJ6oAwKA@mail.gmail.com>
Subject: Re: [GIT PULL] Networking for v6.9
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	pabeni@redhat.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 11 Mar 2024 at 21:25, Jakub Kicinski <kuba@kernel.org> wrote:
>
>  - Large effort by Eric to lower rtnl_lock pressure and remove locks:

W00t!

Pulled. The rtnl lock is probably my least favorite kernel lock. It's
been one of the few global locks we have left (at least that matters).

There are others (I'm not claiming tasklist_lock is great), but
rtnl_lock has certainly been "up there" with the worst of them.

            Linus

