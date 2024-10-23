Return-Path: <netdev+bounces-138152-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D77E9AC6B2
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 11:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C6E41C228E8
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 09:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA5918660C;
	Wed, 23 Oct 2024 09:33:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73AF7482;
	Wed, 23 Oct 2024 09:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729676032; cv=none; b=jhAmlhMo/jjaYTHcwC3UFH8ttTu7azeMvkRT30i4M5fkQbhmC5EeW6U2AXlChS8mUCmGZFyGuyohhT2LR2TG9ODmdeWC3olgbWzGfmhdPQCKukA+yA5eI4I6qjBCm6MIdobyVt/JFXhLr8ZCxtspHawuJdX+SO4W+Me8EIOSh8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729676032; c=relaxed/simple;
	bh=I+t5Y1LPYeVgxRmZ+1UAf49hXymGsrVgLf2jhMU34Oo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kRuPE1K1VqXYzKHfHk6ggpY1EsgFxxEiSE1n8KeYrknd8h359gQymeiN0N11HE5KRNqIiblkcJbj2civcQGF2ZAnJY/I2KdZdvnQPGM260TLJvwunpJRyYIoRRK41y8tBCN3p4tnzDfnCMkxQ5cvpZPzOm3SfSoBeAicOtq9SsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a9a2209bd7fso873190666b.2;
        Wed, 23 Oct 2024 02:33:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729676029; x=1730280829;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nvoMYU14br2JwNAhJzhWrmnAu9bil/nQbgtl7e1GbYk=;
        b=BL/jY7yDd8LV6ZRP3YXm7u5pTkduCXbrV0W2I5s5+yLwF9AyIkWs+J+QCSdqzVX0M8
         ZPrL++lehFOu1zR5sPNWlie4xbKiEjiyT/pvwDcOuNKjPjq3CUwmt5EgPL3vQ6tlUJuW
         vXLdAkdYv47Tv0RFg8nC1TrTY9u8d0pOAoeODH3ILP5J1Ja1I8/LnJHw0sDVQfVjwWmt
         CKlf7yDFJTJoC5/GTD124tffB0RcdGp7391pUJlCcTAnd02Hg0T0+6zSswLnCjtQ+KdO
         nd3fRn1GRtgXiVVRbAF3DpOoP1I9xoXZOG1dfLBYO6YOFinXOvI/cpeXDkm06E7a7aCP
         0Fgg==
X-Forwarded-Encrypted: i=1; AJvYcCU/JZF6n1VnY8pjCFubV4BitElj8xlIPYY9m+3VprrSRIA8M3nPGMBHdKUXvaeCSAKorhd8K2gSNrY=@vger.kernel.org, AJvYcCUKdWxbYD11ER89G2PkhtCx7JANvACQcu32zcIIcD35HPtRDONpX+2RIKxb2I3FeLj2hd8RSrOQYN1HQRHV@vger.kernel.org, AJvYcCUWb0rAEcakXYz0RJZ39uQODaax7+XvykAPaPEaYL6kSABzifTta6Gn8AHB9TcMfOmK65q4MYhL@vger.kernel.org
X-Gm-Message-State: AOJu0YzbIMENjIH4BbKa5enpgFvyNdmI6zYbQwzOVWizFzsp9Jlxkz0W
	0m+ljt8Ua54xXqtJiJcn/KzIWvu3Mf5Q+qmFbp2HJBMJzOa5H/Cf
X-Google-Smtp-Source: AGHT+IH6IguzdeEsuxacjyH9mS3q+nAPKkgRAK8asjxpAb8XRl2duCALzsVvrykgoTpiSWZmOeEw8A==
X-Received: by 2002:a17:907:7211:b0:a99:f71a:4305 with SMTP id a640c23a62f3a-a9abf871265mr154553666b.18.1729676029134;
        Wed, 23 Oct 2024 02:33:49 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-114.fbsv.net. [2a03:2880:30ff:72::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a912d6307sm450952066b.33.2024.10.23.02.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 02:33:48 -0700 (PDT)
Date: Wed, 23 Oct 2024 02:33:46 -0700
From: Breno Leitao <leitao@debian.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Akinobu Mita <akinobu.mita@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, kernel-team@meta.com,
	Pavel Begunkov <asml.silence@gmail.com>,
	Mina Almasry <almasrymina@google.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next v3] net: Implement fault injection forcing skb
 reallocation
Message-ID: <20241023-hasty-inescapable-tapir-a2f7d9@leitao>
References: <20241014135015.3506392-1-leitao@debian.org>
 <d0fa8332-aeef-4d33-9167-b9716b050594@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0fa8332-aeef-4d33-9167-b9716b050594@redhat.com>

On Thu, Oct 17, 2024 at 03:50:41PM +0200, Paolo Abeni wrote:
> On 10/14/24 15:50, Breno Leitao wrote:
> > Introduce a fault injection mechanism to force skb reallocation. The
> > primary goal is to catch bugs related to pointer invalidation after
> > potential skb reallocation.
> > 
> > The fault injection mechanism aims to identify scenarios where callers
> > retain pointers to various headers in the skb but fail to reload these
> > pointers after calling a function that may reallocate the data. This
> > type of bug can lead to memory corruption or crashes if the old,
> > now-invalid pointers are used.
> > 
> > By forcing reallocation through fault injection, we can stress-test code
> > paths and ensure proper pointer management after potential skb
> > reallocations.
> > 
> > Add a hook for fault injection in the following functions:
> > 
> >   * pskb_trim_rcsum()
> >   * pskb_may_pull_reason()
> >   * pskb_trim()
> > 
> > As the other fault injection mechanism, protect it under a debug Kconfig
> > called CONFIG_FAIL_SKB_FORCE_REALLOC.
> > 
> > This patch was *heavily* inspired by Jakub's proposal from:
> > https://lore.kernel.org/all/20240719174140.47a868e6@kernel.org/
> > 
> > CC: Akinobu Mita <akinobu.mita@gmail.com>
> > Suggested-by: Jakub Kicinski <kuba@kernel.org>
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> 
> I'm sorry to nit-pick, but checkpatch laments that the new command line
> argument lacks documentation in
> Documentation/admin-guide/kernel-parameters.txt, and I feel that could be
> actually useful.
> 
> With that, feel free to include my ack in the next revision,

Thanks Paolo, I will send a new updated version soon.

