Return-Path: <netdev+bounces-57396-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 355AE813066
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 13:42:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6580B20A56
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 12:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2164CDF7;
	Thu, 14 Dec 2023 12:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QL40bx0u"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA7BF125
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 04:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702557765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=odMDeThQ3POlCN3WICGaUi3nWoYHxa0pyC3xPvYi8Io=;
	b=QL40bx0uuQ74pLaEZl11H26xQtZEKUjjVJMrOpYxbZyLFbTUE10+XS3W2unsHqD2EUByem
	YE8gtAx7oFDXObx7prFTOmlj6Ly/uFtHR1BcKCffFArQxespn4mNmSpJ+e58KzK0JPg2FX
	YTSic6Z2vEZVVlH4CPaLc/DM6VNn7OI=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-604-GVRr1XhCOKqI5vYmecVmpQ-1; Thu, 14 Dec 2023 07:42:43 -0500
X-MC-Unique: GVRr1XhCOKqI5vYmecVmpQ-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-50bfe590000so1634345e87.0
        for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 04:42:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702557762; x=1703162562;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=odMDeThQ3POlCN3WICGaUi3nWoYHxa0pyC3xPvYi8Io=;
        b=Kk1ct28eEmxu/rmm3qC3xFIPH+/VDROyOxbGJVLg9lLnGX5UqAWSpXYNEoUIrDX1vc
         RQywP6Fusq+jfpeAtcClVJrz22+gfrgg5baUZjTqla3jX8wSx5lxpu57ihYrpXJpEBGI
         OKe8QvjdYIsfmKrdvYps7ozbZpeWPAx4dfOMjvQN+uTuWfiNVoKeEj0LG97opFXB+clQ
         jIuRH9Zb5IPAie5owfp96NVw5Ca22T0QoO3XNjKwjrmyYCWPOvcUPXrFldSL/4LksWfJ
         qbqnn4JIp9TI2WRgL8yV1x0sDoj6RZXbYJRUbtLJMme7rvB4WJnhVg96WVfqrUvuzDSZ
         lvjw==
X-Gm-Message-State: AOJu0YwEoeO6zs2U0nGXcUblXd4Zcfv/Tvu8ylwdtq8VWLrGtrnJy4n2
	PK46GqDgXgrj4govyWX1+Eb23aRTj9iUogN3U/yg/h8f9CZQQGbFxYh65Yz1DcvYf0dH+32j4ed
	+b9sKfj7QVnBssOBcozP3tfpc
X-Received: by 2002:ac2:4c43:0:b0:50e:a92:7983 with SMTP id o3-20020ac24c43000000b0050e0a927983mr5648124lfk.2.1702557761919;
        Thu, 14 Dec 2023 04:42:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFWL+BPctFqS883vEp68aj+Sybet9QzQ4ZLju3jHRNFTYDWRkNuJA8SENH+LGYpkrqldhlDXQ==
X-Received: by 2002:ac2:4c43:0:b0:50e:a92:7983 with SMTP id o3-20020ac24c43000000b0050e0a927983mr5648111lfk.2.1702557761554;
        Thu, 14 Dec 2023 04:42:41 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-252-36.dyn.eolo.it. [146.241.252.36])
        by smtp.gmail.com with ESMTPSA id t16-20020a056402241000b00552743342c8sm570560eda.59.2023.12.14.04.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 04:42:41 -0800 (PST)
Message-ID: <3ab51b1645aadc2db5aef9fb53872be3da436249.camel@redhat.com>
Subject: Re: pull-request: wireless-2023-12-14
From: Paolo Abeni <pabeni@redhat.com>
To: Johannes Berg <johannes@sipsolutions.net>, netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Date: Thu, 14 Dec 2023 13:42:40 +0100
In-Reply-To: <d8667c83111b70144b40a3b7c457c7a2dd440e09.camel@sipsolutions.net>
References: <20231214111515.60626-3-johannes@sipsolutions.net>
	 <ddb0d6217b333c3f025760b5b704342a989f2094.camel@redhat.com>
	 <d8667c83111b70144b40a3b7c457c7a2dd440e09.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2023-12-14 at 13:11 +0100, Johannes Berg wrote:
> On Thu, 2023-12-14 at 13:08 +0100, Paolo Abeni wrote:
> > On Thu, 2023-12-14 at 12:13 +0100, Johannes Berg wrote:
> > > So more stragglers than I'd like, perhaps, but here we are.
> > > A bunch of these escaped Intel's vault late though, and we're
> > > now rewriting our tooling so should get better at that...
> > >=20
> > > Please pull and let us know if there's any problem.
> >=20
> > whoops, this will not enter today's PR, as I'm finalizing it right now.
>=20
> Yeah I kind of expected that.
>=20
> > Unless you scream very hard, very soon, for good reasons, and I'll
> > restart my work from scratch ;) (well not really all the PR work, but
> > some ...)
> >=20
> > Please let me know!
>=20
> There'll be another chance next week, hopefully?

Yes it should.

> Anyway, I don't see anything super critical and likely to affect
> everyone badly. Even if it doesn't make it at all, that wouldn't be a
> huge problem, we'd just have to do some creative merging on our end (or
> reset the tree) :)

Ok, let me take the easy path then - with the next week PR should be
easy for all.

Cheers,

Paolo


