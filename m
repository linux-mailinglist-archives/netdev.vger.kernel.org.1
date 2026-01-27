Return-Path: <netdev+bounces-253917-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eI9FK+fZeGmwtgEAu9opvQ
	(envelope-from <netdev+bounces-253917-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 16:29:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AF9A96B83
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 16:29:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0510230AC905
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 15:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE0335FF64;
	Tue, 27 Jan 2026 15:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KLuW0I+J"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C807B35EDBD
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 15:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769526474; cv=none; b=Z8GrI3e76MJyRLZgTmVoVtkfJqUkwVEAb4ZzyzTwpLBblKJ4zJK1CRTZkdSZUhXCWrE1NRAJDsgBanwR0TZvmvqNPvqKFYnphogoHprA+kj7CzUPaas5KVveH+nUyDxLL7y9KctS/kjel4KXp6RntgP7IivomVyeepOiK4SqhXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769526474; c=relaxed/simple;
	bh=/BjVU7prHk+4d7FH+MQGsmkM+26lnbXBK0gFkSQr6Gw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=drWL5t+c2bbtf708TACAzgVcMira+nLhPb4RWiURewqtIt44E4Wk8y+tS+wK6pm7JMJFjyATqA9AW/Nwfi3OoMTVlvo2E3Z25GFaJvDwuhSr4Rj7fLhLhI5DMYgabCRJKqq4bX1yj/IqiTLDJ/tTosvoUmoGMvuUKFD5nHk5ZkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KLuW0I+J; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4806b88d8c9so919325e9.2
        for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 07:07:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769526471; x=1770131271; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/BjVU7prHk+4d7FH+MQGsmkM+26lnbXBK0gFkSQr6Gw=;
        b=KLuW0I+JbvO+81rSfo4PdjzKUC9VD3sGHm8UfC1smansfje9143PscSbilX1dyQKIU
         qRuQUJZG6QbjYuRFSw4EwaP3zEfFHxIoqy/+91a3XajApV1YqN6EXYhfa5+GOmYozRQK
         irfU4tv2tN/1QwKmFuM4o3UWR4ZgkED2/wiRY5/Cc6wjha+31MZpRzjqpBeGP4PpoTng
         Et61wiNhSQRm3+sn9EKg7FbAYgiRB4BaADN8SO1oUuVwOkhJUVuZlJhO2S2427eZwIUO
         wf9uMDS3KWZ9JQ5sFtb2TTjWZPqiLQ2WQWg4YVIRrc/7Gwf+D7DUkBwblwtUFFY5NFiq
         UNRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769526471; x=1770131271;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/BjVU7prHk+4d7FH+MQGsmkM+26lnbXBK0gFkSQr6Gw=;
        b=J1ffRv930U40v3gqyfw3E2j7OHj0P3euDd+DrAsCPpioqyT0yAzuU6CPWNr03M1rWG
         uBFq9Osiq/wPaCHbo0+KkhUTkXTfoId+s4PmHqb0biw2GYzf0owedlMfYjeDXnLF7R5F
         DS09NZrdZOkTvyYWYKYe3pV1seps5R67UGFXVtx1JdufbP2jm9H2ouBTB/jNZv0e1Wvm
         bgg205xuH1Sm2nJ/g43zy/5W9jiTQaca8ZFyCDZWX48IrjYWC+FUGbOqsjpQSK4IeEgQ
         wXMSyi+bcD+F61BU172poLZU1Aew7aokDtTGIktP4dfCxGsIvMByMkOURuVj1qm4XXLi
         WznQ==
X-Forwarded-Encrypted: i=1; AJvYcCVS+YrUHL1J6fb3TJA38LNjOPHcAis3j5t1LCjQIqsFNF99JdNliAaNCUD+ny6NqkSSwP6CoR8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0/vMMsG86naazhyFQlq9ixa3BE5En0yhF4cQFs3FzHWiO4aRV
	4bIZICQ02/svRh/U6HelwevfxSgMcvaQhi8HXTSTnwXr1ws7YvO7ITj3
X-Gm-Gg: AZuq6aLYqBHUfRdCGEQzeLJ6BNPBa1CKKI7oktpgogutsTGHCtu6G9oguKD4zHh0HmI
	UgXPmI4tfy7fkP0uIYlQNDofVToH33kNpMJFFjC1PhSWCtpOFiKlQG1J01nRZMTPpOpjeJS68NZ
	PbZe6AOA4pKrHWEnFezomSnBHlwTzi1Dx8Cuf5+ChjcxS1a2iC+y5905yAVZ0TwYXFYlAs86gov
	Z+4O7DGh6Dd7KWb5qvWz6URYRtFicduu/8mQ1MLEj8P6fQ60yycI3Ewn0sDU62MZjKYvY4vUkX1
	J5WUGzq/UrG71EtTVQcKtVrg/MZeZmaJwzqgBAcafeUA1OY75rFaTe3aKSjr3xD9QfIDCFerO+w
	Xe8eRGUgw8FlhmiAJ4Sq8lpCoTn3ykn+dpYt5GjH+nW3+JaQ0PTeXefqAz0sA0PsU9RnB16MLvl
	3cQg8=
X-Received: by 2002:a05:600c:468c:b0:47b:d992:601e with SMTP id 5b1f17b1804b1-48069bf34ecmr16877075e9.2.1769526470957;
        Tue, 27 Jan 2026 07:07:50 -0800 (PST)
Received: from skbuf ([2a02:2f04:d501:d900:739c:1012:de93:325c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48066bee687sm105448855e9.5.2026.01.27.07.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 07:07:50 -0800 (PST)
Date: Tue, 27 Jan 2026 17:07:47 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/3] dt-bindings: net: dsa: lantiq,gswip:
 reference common PHY properties
Message-ID: <20260127150747.lzlfzhusywluuxhs@skbuf>
References: <cover.1769519758.git.daniel@makrotopia.org>
 <d9b6212ad5137feeb58b28e9b0784f1084c813df.1769519758.git.daniel@makrotopia.org>
 <20260127132919.xsvapgqc65f44iah@skbuf>
 <aXjGh1nzeAz8TQzH@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXjGh1nzeAz8TQzH@makrotopia.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253917-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[olteanv@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9AF9A96B83
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 02:07:03PM +0000, Daniel Golle wrote:
> Yeah, I thought about that, but it would be a lot of work to
> let the driver expose and simple-bus as MFD with devices (clk controller,
> reset controller, pcs, ...) sitting on register ranges. Imho not worth
> the effort in this case, we discussed it.

Possibly so; I don't have access from this computer to my previous notes
on this topic.

> However, even in that case imho it's fine to let it share the OF node
> with the ethernet-port. Why not?

I don't have a good feeling of how reusable this PCS IP truly is.
For example the XPCS gained DT bindings before I needed to customize the
lane polarity for its SJA1105 instantiation, so now I have to work with
and somehow adapt those.

If the PCS has a fixed mapping to that port then I suppose it can use
its OF node space without any extra overengineering. There should exist
ways to keep compatibility with this scheme even if there will be
efforts to have a reusable driver later.

