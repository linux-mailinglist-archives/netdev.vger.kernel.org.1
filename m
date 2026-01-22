Return-Path: <netdev+bounces-252335-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YL5kNuMlcmkVdwAAu9opvQ
	(envelope-from <netdev+bounces-252335-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 14:28:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F24867438
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 14:28:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BF9686CB910
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 12:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23AF844105E;
	Thu, 22 Jan 2026 12:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HVfkSVA0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA6A3469F0
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 12:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769084523; cv=none; b=kgdYlYwVQCH8bGZW7W9RNCbhmnFussq2SsH4LTErovtUQf5O2H4kW1Rbc1dpJUt0+OXlaugFWR0UqiFXM9ZyCIcVcfGCo6c5Xb6wTe7Zvvrkwo5it3uGUnWpnrCKZRrYAk6P4grgkVT9GBo9jmg4BelnFzph0zycFD6cVVh2/iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769084523; c=relaxed/simple;
	bh=OK/Is7OiF/QIbOd+b74unniU53XJMzKOf0r2wvjUja4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sszB2lqhhOyenNnXXAyvRljADxznu18B9WBd/2lahCdYPPQkmpwHVqmKAP7aEzDwjELHfWBPGKTvoaWo9OONHJ2tdPaOiVACK3jW7saOYPUu8gnMUnilNWyyTdZjNs7xRz2u8zueLiKwT9DGq2y+9aVsAvhOlERmo8RQpEuPebU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=HVfkSVA0; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-4327555464cso593925f8f.1
        for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 04:21:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1769084518; x=1769689318; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OK/Is7OiF/QIbOd+b74unniU53XJMzKOf0r2wvjUja4=;
        b=HVfkSVA0xmaNyuVjqV8m45yy2p81iS2n1ZVnLeFHtGv569GCjSITmB1E3R8U2OdRVv
         uu+toc0R4GiDi4yP+SvQbppnBhPUDjfUgoRnL0a5RvT4Pl8e2IXMdF/b0wP+U95zwCpL
         GaiQfWdxNIem8Ds2RLQPTb4yw258jymJnXqj5eZa5KkcIzDpXXo3u1xslqtQqJLIbFLn
         Ci75yzkoyF8sLnLmnYLoazNjW85dZewuUKdjrH1PgM9g6Z5DnmUMZBmdlh0OelwKXvhO
         q9/bt2eB4EEJH8iShtZWQLigeLjWPEmKqvqq6mQPxWMNfJWXnZk2gzNJUb5LH3akyfPH
         FPjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769084518; x=1769689318;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OK/Is7OiF/QIbOd+b74unniU53XJMzKOf0r2wvjUja4=;
        b=lvCxMApHWW/8ipHoWLZ4xrR0O//ULcF5WNtufxGkTcp8hMLPjYL5wiGCgRcd+mbrCJ
         GwKBFyuRONqLbQUIqbJ8uWnsfOQN8fgMsMQiqMYETfXhZhwyuA41Q/nWZQQHxbtARPSG
         TUQundOgaAkEeiHvAMAL4h8pkxxtf6++7zPXwpkBGGrIxc75koptXzSjcfMkItIYqJON
         v4Z/9fI48jK3SVxn5h2oH3N1Ygw6FVAMYpaeZesaBZoG4fSU4AfmPiLzTsOypcgEm030
         oPJx0eIzCcyXZmzg7FrB9BP802qp44N+ObxIxT1taqhw9b52SjYsY2F2aCcG300i1QHY
         YZSA==
X-Forwarded-Encrypted: i=1; AJvYcCUO6wRQFclcUVvDh6fWMHfaFWRGk5HH9y0D5ElOvK8rscMQpj6gGxwvbgo5OIlR+B7pVTsNzUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxauxNrueXfPpjuVtk9ZEFoGHhOw6sZpfbeEhZNTeDhqPUGv3nY
	Ttu+P4cE5Sn6sX+Udq6qj6MnUsFf35wDBCRP/ZfIax7S9ph0FJnla1aInkW8tXQrOZc=
X-Gm-Gg: AZuq6aIw9IvdN4J6yhW5a54HIY6fVbuL7gtiuqAYX3jipbima1AkrX3Jw6AdpT1EwQZ
	Xvii1wDWClmQquP+OPqGTVDoRpiHU67FE7LYP2WjZ33nXMHBnqjiXpZP9aZ/lNn6uwpvNFoZV0F
	ep18v9Xu1JJpYdzmI1erzKa+9KPn59mIhI6cn+WRDzXqMpVQVYd8pZeZtp5/wpdjaZivlxy2BMu
	aMQT79FyE/6PY+YusNU3wdAoTYL+j3W1OOQrs4ELAx00f12kVa+URLrOH6FRXOEYqP3g/ByzHu2
	V8OWFoJYTe5LRoUvpqk//VPDIial7amereLBFGoO7d0m31WospjCIzLa2CoYbmqkCTcSw80JVFv
	NcmGEBUmoB3FPmEsf9mMAizNXcIGpcWtcHw4VTbtXcEUfVmrmQF2jSLvGwtxXpqm3cGPtlDL6PY
	LoRIBH5rKFyNEkWw==
X-Received: by 2002:a05:6000:178a:b0:431:9d7:5c2e with SMTP id ffacd0b85a97d-4358ff81373mr15303651f8f.35.1769084517657;
        Thu, 22 Jan 2026 04:21:57 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4358e24cef3sm19549969f8f.0.2026.01.22.04.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 04:21:57 -0800 (PST)
Date: Thu, 22 Jan 2026 13:21:38 +0100
From: Petr Mladek <pmladek@suse.com>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	john.ogness@linutronix.de,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, asantostc@gmail.com, efault@gmx.de,
	gustavold@gmail.com, calvin@wbinvd.org, jv@jvosburgh.net,
	mpdesouza@suse.com, kernel-team@meta.com
Subject: Re: [PATCH net-next v3 4/5] netconsole: Use printk context for CPU
 and task information
Message-ID: <aXIWUmhBnFLY6EqK@pathway.suse.cz>
References: <20260122-nbcon-v3-0-a722f2f0dfa5@debian.org>
 <20260122-nbcon-v3-4-a722f2f0dfa5@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122-nbcon-v3-4-a722f2f0dfa5@debian.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[suse.com,quarantine];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,linutronix.de,linuxfoundation.org,goodmis.org,chromium.org,linux-foundation.org,vger.kernel.org,gmail.com,gmx.de,wbinvd.org,jvosburgh.net,suse.com,meta.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252335-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pmladek@suse.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 8F24867438
X-Rspamd-Action: no action

Hi Breno,

I have got only the patches 2,3,4. I can't find the parts 0,1,5 even
at lore. Something went wrong when sending them?

Best Regards,
Petr

