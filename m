Return-Path: <netdev+bounces-227914-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 31220BBD58E
	for <lists+netdev@lfdr.de>; Mon, 06 Oct 2025 10:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D1E9D349B78
	for <lists+netdev@lfdr.de>; Mon,  6 Oct 2025 08:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13912261B6C;
	Mon,  6 Oct 2025 08:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VBUgES2v"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A15E25F98B
	for <netdev@vger.kernel.org>; Mon,  6 Oct 2025 08:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759739354; cv=none; b=rFpSqJV0I4qvP7iui23TGzR5998Wfkl6M6o3jsipYON2iYVtmQE1rdMp8DfWOx0tiP7UDiDj9J0WOPUM3iMfF6mSKHL7a4hyZr6LI4f3IIl09/jBpYBuqtoakje8f5Xik/4IsW85yHc/mFiuOHtIbgzsJ2B76Tvdu6SMrYaiRSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759739354; c=relaxed/simple;
	bh=WTTIsX4n56JtfksdqqFnE9hrH2I7Xo8Q7vw4CQaTA4s=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=TV5RS0qRV00zBW6uToFOB5FnEXMnq6T+UEkLG5UQhavgMgeiFnLWXL9nx6fDFAsl1iKDlMvKFq3bX07iPkZ9zVUcuxge7W0h0qfBVpoRZpRgklj4JKHW4mj9t5bckwAk0BQ+TlyJRTyU1HLlFcqqevTu2z8y0V1/EYsT7aWN6Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VBUgES2v; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-46e33b260b9so44561795e9.2
        for <netdev@vger.kernel.org>; Mon, 06 Oct 2025 01:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759739350; x=1760344150; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yTnBoa0ky01y928/at85SUARueKnaxGdKtxaxPozf54=;
        b=VBUgES2vsI22tOnQz+tU0RG1R48zBfck9EFeqRRD3vRfQBweg2baRwhwgus9h4XyE5
         Qh3xzc4NIsCol2fzv9CwR/n77UlzSn9/xSXhHa8pFOIulxLXl+DMbN4vWqDd+1rgkqgX
         S+8mTUdiKqhlVRl3j7HthRKgz7WmS43vPCvtVrGrQVB3JLUdsB+JL9eu9cQvARXo6rwV
         /xIY8I7ZsG31xy8jn9JhT+XIY/5DPzeEthCQIT22K43oEy/zZ6VTo5aaWJjBkQOGR5qR
         0+gPNLFBU2gCUS5Vvh1WmPsizEHdnTWvfWFA0Dct9HzWfz/AAtb3ShAonIf8V1SlAYZQ
         t87g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759739350; x=1760344150;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yTnBoa0ky01y928/at85SUARueKnaxGdKtxaxPozf54=;
        b=mFWPgnj/ztUU3DqCs3fquDkgBuD9GHKR0ZjdLvHXscGZJjSyCVqiJcvBOjCGgNt6Uw
         4+R5FM2Px+/ERNmlz5pWYi66NIGhWtfDegZ4v78UwcffCumFMqf3292cFwBIkQzhDshO
         fXg7+/1NnuM3Wce+dmXToLWWR8ba6hYmtSdRSvRSIwTtjqSjh0JWlVXzAsW2uMl0alSK
         dnU71xDBTx9lBVTFr/AlR6R17FOSWYNuyR94KeucZwpQh50oCvph49e2Z3Qm2loRrb8o
         RfxG8YAhQ78CNbzGaW5Hd2NeihbdTeqQmlu/LpU0aHfZv+vWjhL2M4T4W1oKk6Yz4My5
         58NA==
X-Forwarded-Encrypted: i=1; AJvYcCVcaaGve1sHT3POuiV8GNuaEwt07EopP1uqRB3MQDtLvtr+9XfxJVpvKR7SIgIHaj84D87DdbQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkjYifgN4QgCbcgFozex9IrO+d6gXfKu+D3VXjn5YxMswncy4A
	d9sd++mRoDA1VYPIBCD68Icfl3M30t5erf24XLjVYw+QiClK5yWmp6n+XyZmvTMm
X-Gm-Gg: ASbGncstgdIrobkW1s9FTjxoH0BN7ftM/O17GVDjFy1gHoBvqrQzVSWE2G4W8Xwrq34
	TvcHXGojn0vgcE5HpYVW+OSBoU2plOdA8SXq4nCHnuO9Ha49+zY9RS0sNsHePTAjgSN5m4lDk1v
	DcW6I+ZSbIWstKvjq31CnHp0YQmDe7fNcEdHZA1yZZ7eZb262MApLA+xpbhHGhY5Geiz8OH24sL
	xWyK+H9exl47eRXRpH2FfTTW1KqZ/tEnOtfQEUwlh4VJoztg0TSAVocDxYfzcA3F4JQ8tJn+yFD
	MUobdSfTwJAjLHANDXqaWYDYnQXfqxK8XfhtYk4I8HQ8DRUw/LWKv1nPDf/tIFXmRKzkpE4g5Wb
	lP0EDkeAHCPr8Yke6BZBpGE6WOBamYbuURpYyV8pjzLOnGRp7FqglxOwOSZRtVVuzvHisNnv49o
	XLDggk
X-Google-Smtp-Source: AGHT+IHmmA8pvw0hIDHbTDF3dRVhl+2UQOTABS190Oi42i1lakvOegmEMarhLggQ19YWcGm1Dh+8gQ==
X-Received: by 2002:a05:600c:540b:b0:46e:4b89:13d9 with SMTP id 5b1f17b1804b1-46e710ac710mr82457075e9.0.1759739349925;
        Mon, 06 Oct 2025 01:29:09 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:10d5:759b:f77e:4194])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e72362344sm149437025e9.15.2025.10.06.01.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 01:29:09 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: "Remy D. Farley" <one-d-wide@protonmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>,  netdev@vger.kernel.org
Subject: Re: [PATCH] doc/netlink: Expand nftables specification
In-Reply-To: <20251002184950.1033210-1-one-d-wide@protonmail.com>
Date: Mon, 06 Oct 2025 09:27:18 +0100
Message-ID: <m25xcssae1.fsf@gmail.com>
References: <20251002184950.1033210-1-one-d-wide@protonmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Remy D. Farley" <one-d-wide@protonmail.com> writes:

> Getting out changes I've accumulated while making nftables spec to work with
> Rust netlink-bindings. Hopefully, this will be useful upstream.
>
> This patch:
>
> - Adds missing byte order annotations.
> - Fills out attributes in some operations.
> - Replaces non-existent "name" attribute with todo comment.
> - Adds some missing sub-messages (and associated attributes).
> - Adds (copies over) documentation for some attributes / enum entries.
> - Adds "getcompat" operation defined in nft_compat.c .

Can you run

    yamllint Documentation/netlink/specs

The patch adds several errors and warnings.

Cheers!

