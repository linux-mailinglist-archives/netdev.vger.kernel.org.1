Return-Path: <netdev+bounces-228895-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF8C6BD5A8A
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 20:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64E0A1897FCE
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 18:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B786E2D131A;
	Mon, 13 Oct 2025 18:11:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8949E2C3251
	for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 18:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760379078; cv=none; b=a+WQl3NfZOHEKMvQnHAVKNXLemWwKQfUz1L6hn9vbjhpYoNml0V8bD0gCp1vSia1V7S2hyBT/6XntzT0laWEdN7I/Q3tHfuVlN7ROdAeGJollIDseV9nXmzYc/A6Si8pTDi+YB2gc542JMHnpxXhwSQwvrz5avM6twsoq8YYj44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760379078; c=relaxed/simple;
	bh=0Bzuud3fbzTgE93y68oTL55XoEOeH0xhkZtO0YadA28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e+pnk4A8H5TCAbQc6rzMUXliuM+NzhhcuIIiD+5NrvmYNjCViJVPK4yllQ5hXvr9QPpn5KuXk42zzAKKKwDSHYD8US3cRjuFrEZBpKcpJ0hMPNQMEx8Mk447hmpj0ac0KCt6gbac4ckR+yLaxLB3KUCzCCslLWO2wuBvycSzxx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b54f55a290cso623065466b.2
        for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 11:11:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760379064; x=1760983864;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NktohjsRp1hmfKBBZVJM9FY0NL3mIXRdvn/tPXzoAnk=;
        b=fGgNUQXz5a38apdNzJvxvazvWODx1eelkPOCAEGFSlD+b5eGIGACH1RCDjhAgBmC2u
         bt26Ww9a7rVUXcsPDdsXojuQ38g91GFoZ+Te9SPBxdic5fI+4Tej1MnbTrMaA8F0uPiw
         EunTdAs+hRjhNn24YPrx49UOSgb+iFW+HXZH8muMKwzULDdr3aeXDoi9h36fdgUrAH+6
         UpDUBrvwCLqezW5JyK48nu/Wke/RJiG/Vn8HdMe4APSS2muRukv+fT6VR6ZU9qplcqYd
         vohC3F5g293EQPMNuF+4dkaYcqlt+Dps5hMwQWUVeGm80k+CDWPgZ98Ul9h/y2q1U0OP
         TBoA==
X-Forwarded-Encrypted: i=1; AJvYcCXCN6jKHCWXUkIAn6/w6E+VAtMldwIuoZqOR8NOLTNtnwqtV4/3F2WVVgC+2GOLliXoMZGCb7A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXcD1Z3F9UiTZ2wFJxySEzEyX177a1o7FFCpmpG0mIi1EPnKOf
	LjLG2PpdZtUjdFIZms+p0nGYBr+C79/FRyoa6FiIGcZnLzhkF8w2jMiD
X-Gm-Gg: ASbGncslN1IVXTV33SyRYAO9QgQ/q9baNaGIbeAeZjKHHghe7iI1ZbZPXbX10Ot2T2h
	lnkQEgfZmEO9wg5IBMiMKCsAPScUwq6STQ4WmL18WpnERiVT9l4q4ii0bMUPA+4Ez0HjqSBXLpr
	NWJRk+RatoCrjCVOzqw4IGAZTvVkMMJ2ApfmbHou+kIRTWX8yIa/cPIDYMqkBS4szLnQ/wddizL
	/DznX0u+fZdtQDnODSAyKdbzqKl0L+YQKZZSAIDkr8DCZHuQ4BNLhU47HXr73ES3z6lvt2Lcf0i
	gb8ULgUJFCDfmQ9PQNxDR9hotSPNoElB5+8dnrRB80Dm/Kpj+K+ihVPRhwiVi1rcgVywh3n6GjC
	pXmksaocXLqkVG4Z+a7YNIsKNydLhnyqgWPsGZcPtPMD9Zg==
X-Google-Smtp-Source: AGHT+IHbes+6c9B6vBDGbbc0VnnI9qPJtLLBClW/BkZx58Er6Zqt3ZVOHaRjm9I+D9i4QTYnlUSGfA==
X-Received: by 2002:a17:907:7f8f:b0:b4e:a47f:7157 with SMTP id a640c23a62f3a-b50aa9a1d23mr2461363366b.19.1760379063674;
        Mon, 13 Oct 2025 11:11:03 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:7::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d8c12c48sm980952466b.50.2025.10.13.11.11.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 11:11:03 -0700 (PDT)
Date: Mon, 13 Oct 2025 11:11:00 -0700
From: Breno Leitao <leitao@debian.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, 
	david decotigny <decot@googlers.com>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, asantostc@gmail.com, efault@gmx.de, calvin@wbinvd.org, 
	kernel-team@meta.com, jv@jvosburgh.net
Subject: Re: [PATCH net v7 4/4] selftest: netcons: add test for netconsole
 over bonded interfaces
Message-ID: <3aozzslkx7jpiabyvey3562i57ogqkw2wb4xfp7uazidj572p6@jg6lw5dzxxto>
References: <20251003-netconsole_torture-v7-0-aa92fcce62a9@debian.org>
 <20251003-netconsole_torture-v7-4-aa92fcce62a9@debian.org>
 <e6764450-b0f8-4f50-b761-6321dfe2ad71@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6764450-b0f8-4f50-b761-6321dfe2ad71@redhat.com>

On Tue, Oct 07, 2025 at 11:47:22AM +0200, Paolo Abeni wrote:
> On 10/3/25 1:57 PM, Breno Leitao wrote:
> > +# Clean up netdevsim ifaces created for bonding test
> > +function cleanup_bond_nsim() {
> > +	echo "$NSIM_BOND_TX_1" > "$NSIM_DEV_SYS_DEL"
> > +	echo "$NSIM_BOND_TX_2" > "$NSIM_DEV_SYS_DEL"
> > +	echo "$NSIM_BOND_RX_1" > "$NSIM_DEV_SYS_DEL"
> > +	echo "$NSIM_BOND_RX_2" > "$NSIM_DEV_SYS_DEL"
> > +	cleanup_all_ns
> 
> If all devices are created in child netns, you will not need explicit
> per device cleanup.

Humm, that is what I was expecting as well, but, when I tried it, I found that
the interfaces got re-pareted by the main network namespace when the namespace
is deleted.


For instance, in the following example, eth1 belongs to namespace `ns1`, and
when I delete it, it then moves to the main network namespace:

	# ip link

	# ip -n ns1 link
	3: eth1: <BROADCAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UNKNOWN mode DEFAULT group default qlen 1000
	link/ether d2:3d:b3:3b:59:37 brd ff:ff:ff:ff:ff:ff
	altname eni1np1

	# ip netns delete ns1

	# ip link
	1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1000
	link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
	3: eth1: <BROADCAST> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000
	link/ether d2:3d:b3:3b:59:37 brd ff:ff:ff:ff:ff:ff
	altname eni1np1

