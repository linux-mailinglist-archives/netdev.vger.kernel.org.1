Return-Path: <netdev+bounces-77394-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B929887187B
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 09:44:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCE971C21C3A
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 08:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 236ED4DA0C;
	Tue,  5 Mar 2024 08:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UNuyNVJq"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3322A4D9F9
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 08:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709628249; cv=none; b=K8jKOI1dWygI/BI+HtckcAg+UQTSIvkg4fmXx+2kBstYDL117Y75nBC7ON0q5Zqwx00s1SDbwq+YX8XvteywL+hZAZU/AksN07inBlBJZCleVPeJtXkiNGZshR6lftbX1fKU7ovMcNCUC4Ol/veHl8VsZ4KktgU6Wi8tAYIMdT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709628249; c=relaxed/simple;
	bh=nvsjlM00qaONSuvI4QwqHZNjKhE0FYReAVtOrS/ry5I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LVa3GBjlYJl7Iyrc2l4ZDGVLT6M/K+uw7r3X2UNoRnDwzqYOCM4qvF8tpGr2vypjthPrto0ZvpPE9D6hJi3JrYNuhtGCVgXge8b6muqiQGftT9IHMzrIgqi/SmWWL2/fH8snVDFxXMPZnOuSzVX4LNXsn5H4YZTpAoZPgCZyNIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UNuyNVJq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709628246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=mbDZL2iuHH58VTBeAEjTzOVEeS6/mST5ws7QYdMc2jY=;
	b=UNuyNVJqxxBkTe7bVy7pMoTz/snUu4nC5CpXA4abagCfvZ+PjWMzzNzMMGKNDTwEnh9e+U
	Lxh6Vktzv98y+6EU1rigDVyDRkOC3g/opaKHUB8ZiNRM/I3WbvOot8nnSt4CKIg3JcWyAF
	eZfxRyseezN+BJ7yj7ypZfUslaL1OcQ=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-17-Vy5pQUwEP6ONhXmXkRq_5g-1; Tue, 05 Mar 2024 03:44:04 -0500
X-MC-Unique: Vy5pQUwEP6ONhXmXkRq_5g-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-51286ecce59so833034e87.1
        for <netdev@vger.kernel.org>; Tue, 05 Mar 2024 00:44:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709628242; x=1710233042;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mbDZL2iuHH58VTBeAEjTzOVEeS6/mST5ws7QYdMc2jY=;
        b=ONdED8BbyZjFMyC9rW9JgxBUQDrjnaSJb7gGcU2uwgfSi1JZWAGgovf6Aij/9FL32Z
         9ti867YbNVJWyy767F6LtvlPdHsS1AncZ75+zadEWVRukSLcEXqQPDH5Bp36EDlBmE9h
         GDO2Rhvdx9BChf7QaAANOlBFJHcLLdB0rGuvuZ0JiOar3fG7S+Ker+vKbnOy6IXMOW4o
         VVz0BqaJsyJ/Gm5zgKX5aHo4suCoqjeCMAaL3u4A+FeHlnv0lHxfL7roF8ycKpuP1Soj
         xmQIi4ZNUAOLtjVzf4mpEY9zZm9Q6gDX7+MVc39cZ3w+K3OgN6jUpioL1Gnx0CHg+NcH
         a4NA==
X-Forwarded-Encrypted: i=1; AJvYcCWvgGV5x+tdmNQ58QBpm7vJ5P2OAz9KmnC+luilIQ+GTaVdvRpqB0sO3UBuHUYPxHCxHCJZ5O4CgpLxZgkLYYbZ5uhQ06y9
X-Gm-Message-State: AOJu0YxRgZoh9PorPu4d1vtzpACDkkaOi+kJV+33YI0cfg2obMpqDGGy
	mV1IFYyZAd9XarwgCkL2BdzclUrK38dtIl6E+1CpaQE3BrqZ1GFRH70bO5khgh9gTO+tvfeMiev
	fgOhm9WGashEHxW28gfB7jOHpqA0+BQ6AUGTpxj55iBekSd/sAruL8KwLGT9Jkw==
X-Received: by 2002:ac2:4648:0:b0:513:2fcb:da02 with SMTP id s8-20020ac24648000000b005132fcbda02mr6198786lfo.2.1709628242571;
        Tue, 05 Mar 2024 00:44:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGSi5ABmKwwcutK31LAFoFIaYf3GeO4MW7xSEXXZ9ZDpHGPEXMWJKy9Z+2IRfO96T9bTFCxBQ==
X-Received: by 2002:ac2:4648:0:b0:513:2fcb:da02 with SMTP id s8-20020ac24648000000b005132fcbda02mr6198774lfo.2.1709628242077;
        Tue, 05 Mar 2024 00:44:02 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-235-19.dyn.eolo.it. [146.241.235.19])
        by smtp.gmail.com with ESMTPSA id o17-20020a05600c4fd100b00412d68dbf75sm10113738wmq.35.2024.03.05.00.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 00:44:01 -0800 (PST)
Message-ID: <0bddd6e22f91e0d629b41a84c9e2eb56e3260176.camel@redhat.com>
Subject: Re: [PATCH v4 net-next 12/15] af_unix: Assign a unique index to SCC.
From: Paolo Abeni <pabeni@redhat.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>, "David S. Miller"
	 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	 <kuba@kernel.org>
Cc: Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Date: Tue, 05 Mar 2024 09:44:00 +0100
In-Reply-To: <20240301022243.73908-13-kuniyu@amazon.com>
References: <20240301022243.73908-1-kuniyu@amazon.com>
	 <20240301022243.73908-13-kuniyu@amazon.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-02-29 at 18:22 -0800, Kuniyuki Iwashima wrote:
> The definition of the lowlink in Tarjan's algorithm is the
> smallest index of a vertex that is reachable with at most one
> back-edge in SCC.  This is not useful for a cross-edge.
>=20
> If we start traversing from A in the following graph, the final
> lowlink of D is 3.  The cross-edge here is one between D and C.
>=20
>   A -> B -> D   D =3D (4, 3)  (index, lowlink)
>   ^    |    |   C =3D (3, 1)
>   |    V    |   B =3D (2, 1)
>   `--- C <--'   A =3D (1, 1)
>=20
> This is because the lowlink of D is updated with the index of C.
>=20
> In the following patch, we detect a dead SCC by checking two
> conditions for each vertex.
>=20
>   1) vertex has no edge directed to another SCC (no bridge)
>   2) vertex's out_degree is the same as the refcount of its file
>=20
> If 1) is false, there is a receiver of all fds of the SCC and
> its ancestor SCC.
>=20
> To evaluate 1), we need to assign a unique index to each SCC and
> assign it to all vertices in the SCC.
>=20
> This patch changes the lowlink update logic for cross-edge so
> that in the example above, the lowlink of D is updated with the
> lowlink of C.
>=20
>   A -> B -> D   D =3D (4, 1)  (index, lowlink)
>   ^    |    |   C =3D (3, 1)
>   |    V    |   B =3D (2, 1)
>   `--- C <--'   A =3D (1, 1)
>=20
> Then, all vertices in the same SCC have the same lowlink, and we
> can quickly find the bridge connecting to different SCC if exists.
>=20
> However, it is no longer called lowlink, so we rename it to
> scc_index.  (It's sometimes called lowpoint.)

I'm wondering if there is any reference to this variation of Tarjan's
algorithm you can point, to help understanding, future memory,
reviewing.

Thanks!

Paolo


