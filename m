Return-Path: <netdev+bounces-271290-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MAPjBy32wmkEngQAu9opvQ
	(envelope-from <netdev+bounces-271290-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 21:38:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C22B31C66D
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 21:38:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 37A3C30498D0
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 20:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 535743559D6;
	Tue, 24 Mar 2026 20:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kIuhwMpi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2675E32570D
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 20:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774384675; cv=none; b=i+RN5bkhRTfwkvntVHY+G5qBiuUv7TZ71GOi9QQiNNsbsYZlxxB4sanaMGUjcWfGA86vwAyEweFrmlMF8+jtSxwoknJbFNDkzjsVrjPr8fYzdBrLqMWvrUKu3v7HWWJB6pff9jUoFtgxjxmmcymcMnKaxGbb30EU7ir87RsrF30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774384675; c=relaxed/simple;
	bh=IklkjLATlhSfvXu9U0yE9o9pqeUlXUQB8n33/ftghlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iTMJDydI+eGgjt9s/Tm7Y6PcYQb3/0JVJlgQdY8VbagCnMAvfjgPEe5wEUoMp98RPHDF0dyovBl0m560k4F4hvhWjpfNGf50bbf3zJE450DoK20LDZLVNnINdoDL7lv7HZQeaEQr/NCmzKQgP+bJqcTnNpPseuxsJNBpR0k0nLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kIuhwMpi; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-486fc49c5c0so7131315e9.1
        for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 13:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774384672; x=1774989472; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sgql0MyLDOQ8UuWtaXH7Bswik057ZQdszxV1uJR1XuU=;
        b=kIuhwMpi4eYdcPRzFUpXh1EyeAPIabkVVkV+JW3nf5MHRWi+dMMnf7rpexfr3VQvkH
         lJD4zfiz5mxE1UehJcy6DmbAdrNQ3j4CilnMJzlAPVUivrWQvD6cdiPoTCr7zPyUszV2
         RB5fGw9jFQvfXGznoZayMDHKqrKvm4wHtczQXl3i36CdU9wKy7AqL11PWxDDraLgQNqs
         qQbVt7o7aPB4i7D+jJnjtTgCj1t+kfop0Pd+L27UuIVRQtyw3/haw1r/kA/mw3Jeo5x5
         teJqjTW6Wzrx4kpvtac4b5b3u64+u9vGRW+6pY3AhGoiR963xfhAcw53bkpymgwmwSv2
         l2wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774384672; x=1774989472;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sgql0MyLDOQ8UuWtaXH7Bswik057ZQdszxV1uJR1XuU=;
        b=hotKzpxdWvEzVo3Oyz9S4vIm7HP4pi+9IHnfTAjwCfwFXMOZaYRcdpfZR5a6SWVZD6
         jynYy9L75c1/v2A92zlJHZ4O8aRBA3i20d3jAN7HgqXQlSO4eS7KujbysYKmJsxQT+bI
         83KPjOuVa31dSYV3fk3PG6jipnsEbor4QrvV9vMX3AHegQL0Bda3tmsFnTDFOKuHpX5d
         B8/ONomV3CW2PoWOdmA11g5cWyLCCfZwSDDkzqTNfko7KP5stvAGRMITXlc38whgODVL
         DgpzsSmDA32aKW26mZqKlNcYVveoXScechlkbk6Hv5cR/F5+Ja1MUHrgq2ecp64cJcQu
         29+w==
X-Forwarded-Encrypted: i=1; AJvYcCUMqFVJUEAGpxUCKr/bL5FlYgDgCvA8h9LWc431iP4Gjd85cG9XgrW/RKRre+dsx1VvcvBQeTo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvohhC1C3mCAMCXGYp1cz+BplbZiEBSI3Y4TVaK+/CZv46eVw0
	McppVqQEcwLoOX9O97c1xqpNQSfPnJleZZuNMwI3dfXngtGudUMZeADy
X-Gm-Gg: ATEYQzzGN6BavtmwDjWwY6xef+7qRg5so09plofvInpWdp9YqarxzKOrQv3PryaOm6q
	36hroqZb8fAuZfDYMHrZnII8YzvGiTi5F+9e7TsxoOeSwyJZqrJHfVgjESGxYOU74LWFAPZH6DA
	aOlQAqBQvQ7R6xGX0CSNrTrGBl+qHKSi/J+httE0eTG+z1iAhqQLHHNbGOZqWjyDkATGXoThnLv
	AV+2Ss3dr57nyhAWd9C5l1Rs6Kfeu/7riSV1znQf/ZxfMYwtEURNoWxOSV9/t4AFRIKFUnuJ+KL
	GPRcjjl0n91i/MDdsRq/RC0lFAvgS5HAJU7rnwjJz02urVB4vbi6qYVV1H/YMDK0gM3pczjOzmi
	AeqZm3Ql0B+VXrwDqjrn4L2fjXj7gRE1Qrx9q4lMaQ7BCVeOc9a7jCOJ7fg/3cn3U06n5gosEyD
	f7EnWF8NVa2WSxlA==
X-Received: by 2002:a05:600c:1e8f:b0:486:fb8a:fd9 with SMTP id 5b1f17b1804b1-48715f03256mr10577575e9.0.1774384671454;
        Tue, 24 Mar 2026 13:37:51 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d50a:b400:1955:43a4:bdf:48ef])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b881757c5sm2685265f8f.0.2026.03.24.13.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 13:37:50 -0700 (PDT)
Date: Tue, 24 Mar 2026 22:37:48 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com, thomas.petazzoni@bootlin.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: dsa: microchip: drop an outdated
 comment about SGMII support
Message-ID: <20260324203748.huucjfum6nlo6b5o@skbuf>
References: <20260324180826.524327-1-maxime.chevallier@bootlin.com>
 <20260324180826.524327-3-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324180826.524327-3-maxime.chevallier@bootlin.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271290-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[olteanv@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9C22B31C66D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 24, 2026 at 07:08:25PM +0100, Maxime Chevallier wrote:
> SGMII support has been added to ksz9477, we can drop the comment saying
> that it'll be added later.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

