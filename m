Return-Path: <netdev+bounces-181428-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D19FA84F76
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 00:04:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D82069C1BE8
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 22:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6ECD20C48E;
	Thu, 10 Apr 2025 22:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="buw4eI0E"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD8BEEB1
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 22:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744322678; cv=none; b=e9smZULbu6FWhAf4eFHj/LxFrB7PD0qCmCAtVAOA36omP2jQMWcb/VQhZZGVLWTHPWCx+Qu/xFwYOABf6ncZGOhUQ/lu+vyWeDiL4oKX9M+RGuxMoU0DSbfV44MYGSUGybNiIIrlK2QPpgYQYZEs0lP0T6USdUKSXrHWocMjnNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744322678; c=relaxed/simple;
	bh=3uMBL4NPv3raozz5zKjQqEnw2j9SO97i6WwFa10I4Pg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=K+RvHtr8k486lawTjyvyqqlI2Bog4ywUPyWamfLZNDrBUuW+/wLtmtgENt8aHFVh86N/fTE2caDXY5lgCnJux+mxiplMng9iXBkxEcIO92JRuOnShFTRBDbGPzXJV8WbYz9kWBHP82U5xPRLe7TpN4i1hxG9S4u23EKVMpxuW6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=buw4eI0E; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-224191d9228so15732935ad.3
        for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 15:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744322676; x=1744927476; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7eShhCni2AeN9U5Jc2b4WOHTyOiv0aqWO9tX2xSw/mU=;
        b=buw4eI0Ew8YyxYMlNAw2MV0sDnSI9Jt4cME7hQ7K6ri8ObB78VB2nPmP8AEUifrX5Q
         y8I3j/isiLBhVq0GGAfoozJQ8fyS+o87LIV3f5g0AUSu9X/rSBh8ax2cqoSz+kXECdvB
         skYi+omBcOZKf+gAC3CsA1XlURcw3wCxBb67HMZGL67kZgWI6wg2WyZPVsYXHUZupmej
         D2lRthryU/drznbrggBKdcmCj+q8pCgkmKiH8h+BaQ+1mP3renvwzQszGk9YEoho4Kwj
         bF8Zx/EMcZ2IaPRoG/PBvYbIuKs2aZpnVwMFdtd1tXcEQ1W7DKiDPPYT4wfENJLAd/Qd
         nnSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744322676; x=1744927476;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7eShhCni2AeN9U5Jc2b4WOHTyOiv0aqWO9tX2xSw/mU=;
        b=a8YFDthG3GhrUgnSUMYMSiC795dW/f8QEsmGJwhjhl3LDlB8KQt1KYN56wTVs2QunI
         icbAjoquQAn8MYnLE4i0tmnSIuAwkcgPjVqqY1uMl1T4+JoobqeGd3fmHvXo6qIFHnIL
         q5GdadQSDwCj84V+9tAIkPD3zJqoekn3EYQvNlDJqyGjhFyQgjCDiQb10PmVmUdslOqY
         yHSo8YlWHARLLgcYnTpGTPI/L0WzHaKan19CmG2mJVJWTPaar9e9ibTHqx1XaTTJuzQc
         tV+zD1rl7/4eOeca4kiTHdVwfACl9AcTHCPZC+JE6B0lbo5hWLDChXNd/tc6fkuczv15
         eikA==
X-Forwarded-Encrypted: i=1; AJvYcCXZuSodwd+q6QwE8aVPZ+9K7XiLMmxe9e2edgd/xxojTP9r9zi6wOROaidV+quv1WXMesUl9f4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqvKgKP1pUTG+P7ZQpQcok0tPfVFzxEG1AOheU35dXtF8xiVJq
	QtHGp7P14t28/s4wrgdGywbKhzFX42BKst5Caa7mT/vObLpEwG8iCpiTbUw4RK//YAxGpwlGmi5
	Q0g==
X-Google-Smtp-Source: AGHT+IE/nhiyEmsRhP2rb2VCXmUB28XKf+JD6SxynR/MURcWw+q3szzXjCCZ52+kyzlA5ipAqMNlMQqrrE8=
X-Received: from pltj8.prod.google.com ([2002:a17:902:76c8:b0:223:3f96:a29c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d481:b0:220:f59b:6e6
 with SMTP id d9443c01a7336-22bea495687mr4890535ad.8.1744322676625; Thu, 10
 Apr 2025 15:04:36 -0700 (PDT)
Date: Thu, 10 Apr 2025 15:04:35 -0700
In-Reply-To: <20250410152846.184e174f.alex.williamson@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250404211449.1443336-1-seanjc@google.com> <20250404211449.1443336-4-seanjc@google.com>
 <20250410152846.184e174f.alex.williamson@redhat.com>
Message-ID: <Z_hAc3rfMhlyQ9zd@google.com>
Subject: Re: [PATCH 3/7] irqbypass: Take ownership of producer/consumer token tracking
From: Sean Christopherson <seanjc@google.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Oliver Upton <oliver.upton@linux.dev>, David Matlack <dmatlack@google.com>, 
	Like Xu <like.xu.linux@gmail.com>, Yong He <alexyonghe@tencent.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Apr 10, 2025, Alex Williamson wrote:
> On Fri,  4 Apr 2025 14:14:45 -0700
> Sean Christopherson <seanjc@google.com> wrote:
> > diff --git a/include/linux/irqbypass.h b/include/linux/irqbypass.h
> > index 9bdb2a781841..379725b9a003 100644
> > --- a/include/linux/irqbypass.h
> > +++ b/include/linux/irqbypass.h
> > @@ -10,6 +10,7 @@
> >  
> >  #include <linux/list.h>
> >  
> > +struct eventfd_ctx;
> >  struct irq_bypass_consumer;
> >  
> >  /*
> > @@ -18,20 +19,20 @@ struct irq_bypass_consumer;
> >   * The IRQ bypass manager is a simple set of lists and callbacks that allows
> >   * IRQ producers (ex. physical interrupt sources) to be matched to IRQ
> >   * consumers (ex. virtualization hardware that allows IRQ bypass or offload)
> > - * via a shared token (ex. eventfd_ctx).  Producers and consumers register
> > - * independently.  When a token match is found, the optional @stop callback
> > - * will be called for each participant.  The pair will then be connected via
> > - * the @add_* callbacks, and finally the optional @start callback will allow
> > - * any final coordination.  When either participant is unregistered, the
> > - * process is repeated using the @del_* callbacks in place of the @add_*
> > - * callbacks.  Match tokens must be unique per producer/consumer, 1:N pairings
> > - * are not supported.
> > + * via a shared eventfd_ctx).  Producers and consumers register independently.
> > + * When a producer and consumer are paired, i.e. a token match is found, the
> > + * optional @stop callback will be called for each participant.  The pair will
> > + * then be connected via the @add_* callbacks, and finally the optional @start
> > + * callback will allow any final coordination.  When either participant is
> > + * unregistered, the process is repeated using the @del_* callbacks in place of
> > + * the @add_* callbacks.  Match tokens must be unique per producer/consumer,
> > + * 1:N pairings are not supported.
> >   */
> >  
> >  /**
> >   * struct irq_bypass_producer - IRQ bypass producer definition
> >   * @node: IRQ bypass manager private list management
> > - * @token: opaque token to match between producer and consumer (non-NULL)
> > + * @token: IRQ bypass manage private token to match producers and consumers
> 
> The "token" terminology seems a little out of place after all is said
> and done in this series.  

Ugh, yeah, good point.  I don't know why I left it as "token".

> Should it just be an "index" in anticipation of the usage with xarray and
> changed to an unsigned long?  Or at least s/token/eventfd/ and changed to an
> eventfd_ctx pointer?

My strong vote is for "struct eventfd_ctx *eventfd;"

