Return-Path: <netdev+bounces-223231-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5756EB58760
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 00:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9759B3B795D
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 22:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B5A2C11F9;
	Mon, 15 Sep 2025 22:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Oh/Q+ymL"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA57615746F
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 22:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757974841; cv=none; b=AIZ0zciNGwz5eU26D/0W3NFPKx/wThtvQTsbr1Bev3TTvcMfTgxAmA35yx6ibYPj7N8h5ZjnsENroYAJh2OXjZBfZV/GBEd3xaSdNyGSLyk+gOyd8pbclYnbfNzY7nHLbMRGYx817IcY8TL7Ohva761tDY5XAh/gj5FcUMBSWow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757974841; c=relaxed/simple;
	bh=d1A4ZSLlQNC4zFoOiM/19Q9nc4Ro68qdi9KXC/JTmwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S4edototeeBhadfIxJMN86ziJ+AQ0no68J1LFjumQlRFZ0t6uxMCPDsmqTc0As/N8Rszz0uiJkNYz1q8/i79XXNZXvSGRt1K+b0zZ3XIAIhetMZBf1va2/B+QZiHH5dZDJ+fI9FrN2yzzXyGzMPsVP3o1QDWe8OUq57G6pMq/7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Oh/Q+ymL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757974838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zNCvg1SlA5uujYmTpj5dnM2XRiOsxEhqFlXcwCOlTYU=;
	b=Oh/Q+ymLuJpcQtYiQAiTANVW0UPpdYz5v3ZaszVqDxVAvAGFhgtu7YIfeeUvuANJItgdfD
	0BiAnmSrcnal3HdPk2nm52hm0xxvcg7MW9uqXJo0ue6MNHOgA+R6TxpfzA1eB74mEeAapY
	2ez5dqr+FikRE3lmFfU+PFZem4dPyp0=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-224-GSWJXDGOMmSrSXpNAx2pUQ-1; Mon, 15 Sep 2025 18:20:36 -0400
X-MC-Unique: GSWJXDGOMmSrSXpNAx2pUQ-1
X-Mimecast-MFC-AGG-ID: GSWJXDGOMmSrSXpNAx2pUQ_1757974835
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-afe6216085aso58820966b.1
        for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 15:20:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757974835; x=1758579635;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zNCvg1SlA5uujYmTpj5dnM2XRiOsxEhqFlXcwCOlTYU=;
        b=qf3ghkgwyyB+XXoAP2D7BeViiwEHmTx6FEngUXjrA9bgE30s6H+6mNHP1CYae9J+oV
         3KB7+L3yob3C/7GOyWyqeN+40gPjUtSXsNc/WNEgmHiCWEOrHM1vQa7TO4fur9oyK7F4
         GIIy0/9U6+MWFmwYQDQpiFjlJH16LWiRm7kbbdK/FUG9paXtvbLJ1XN/c8kh18eyQsLl
         5ruVVS7zLg449YKe7szU47jkjmBeLAHdP4zL7lO0CDmuO+NUPi5rIP5nS/whCZhJm4Ya
         P5ts4e0CzfVSFQqFrE/BjJkdOfp8+DdfDCvyolVGKrMaeumUdzPusdDUki+AjC7V++jE
         fLtQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1UVQdBHjiApJDar2m2lbZpXxUPik4lt2XvJL6hOQdfk6eUxrxe10cfJS5QW+EK4k4yrHvCtM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwENZrYQ4TjoiQGQguW3QyguCBO0EXjLEdQ0VECHmGjyYY7m493
	TUa5CQyFOEWfVK5CUdu/hhOLF1v3jXqQqEX7EFGPAZMa5Tr7LDGdASdb8RTv4bOX1eJiOYq0pKb
	9jU5U45djNvUbNzvNljWw8Y7RFDAm7M5ISS/8PTi2H963ZjlUP/TfsMSm1g==
X-Gm-Gg: ASbGncuKqdA2StOlY8qJE2hc4ArfX1lIvXsfcQWOrSRLl04tnOdr6bBk8bwX+jlYbnm
	3x7QCgoMe3+tTyJcEaX6VBamaoHY2KV8CHT7ZGUPqfL4Awt8Sp22b1xgqVEA4zfuFL+Xm1TDNQ8
	G/p5gh0wqtiQvfTltUBX9+UGBYT0Sx7ekKnCUXmJnTmhSE7hgGROWhsigRci/HBX+M9bolgpomN
	WlS/DMhP0hny8HQVuILFzVStocQawFOCN78mEeWk3CR/sykVp9br6XVWjwY5M0mpYmHa0BvHFG2
	0cadxjTuc8zZwI7JDbWtqOIbWtpH
X-Received: by 2002:a17:906:c146:b0:b13:bdf0:3b88 with SMTP id a640c23a62f3a-b13bdf03bc2mr340562366b.43.1757974834815;
        Mon, 15 Sep 2025 15:20:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDMmlY+A7AncdQvX7lWK2y0LwK1/e2IwXHvw4zMrKcaIUHt6jUeNuT8DB6d4WnPa6JGwjHvQ==
X-Received: by 2002:a17:906:c146:b0:b13:bdf0:3b88 with SMTP id a640c23a62f3a-b13bdf03bc2mr340560366b.43.1757974834411;
        Mon, 15 Sep 2025 15:20:34 -0700 (PDT)
Received: from redhat.com ([31.187.78.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07c2d043desm854739366b.40.2025.09.15.15.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 15:20:33 -0700 (PDT)
Date: Mon, 15 Sep 2025 18:20:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>,
	kvm@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v2 0/3] vhost_task: Fix a bug where KVM wakes an exited
 task
Message-ID: <20250915182018-mutt-send-email-mst@kernel.org>
References: <20250827194107.4142164-1-seanjc@google.com>
 <aMh_BCLJqVKe-w7-@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMh_BCLJqVKe-w7-@google.com>

On Mon, Sep 15, 2025 at 02:03:00PM -0700, Sean Christopherson wrote:
> On Wed, Aug 27, 2025, Sean Christopherson wrote:
> > Michael,
> > 
> > Do you want to take this through the vhost tree?  It technically fixes a KVM
> > bug, but this obviously touches far more vhost code than KVM code, and the
> > patch that needs to go into 6.17 doesn't touch KVM at all.
> 
> Can this be squeezed into 6.17?  I know it's very late in the cycle, and that the
> KVM bug is pre-existing, but the increased impact of the bug is new in 6.17 and I
> don't want 6.17 to release without a fix.

To clarify you just mean 1/3, yes?


