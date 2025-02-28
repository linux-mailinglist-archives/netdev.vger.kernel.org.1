Return-Path: <netdev+bounces-170602-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 07FDFA493DB
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 09:45:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9C8D7A0730
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 08:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5CE253B51;
	Fri, 28 Feb 2025 08:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cQFcXAi/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E711DDA3B
	for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 08:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740732335; cv=none; b=fUvIzMQpHBMn2svoKZvMTNXsSR9LWs8PvR2v7dp4Jkmgm3z1SZ5cbiPSdvPr0yr4z+XeMyaepgOWzQz30inFSGGT4ukOL5DIBPi0GseY3s/kVquaZIUysIXCGWR/9y1bzzKE6QSZBPSahXlZ9xKMahcrxvA0nMtbuM96wePsJgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740732335; c=relaxed/simple;
	bh=2DkF+HrYwJarAm+V6tPjIZWkJC9BCfK8Juksw+yULgg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bttSoCEh/eZ0ndgtepW8Kc/sjzZqYUQ62jYkrN6YhqnUTkLnTA4H5GiHZ4W2Sa+uMyk1uYTkS+wHlYT1uSh8B7mqJe7NOFTWO71mD1EbeDwINkuMQ+bH6Iry6rO80EjTTOr89MHT5J+Q4Hw7AfTodm9mME06X9g9fVv4YDLVCvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cQFcXAi/; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-474bc1aaf5fso10240021cf.0
        for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 00:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740732333; x=1741337133; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2DkF+HrYwJarAm+V6tPjIZWkJC9BCfK8Juksw+yULgg=;
        b=cQFcXAi/SnWTTSZqtjx1vkdsNjUbYnq1tvMwc4dbXcvT2O46lYsTre13H/2n6cPHsi
         zHf6EGlHFE/TO6/iTzdvj3638iTCA4evNtvBIuKh4/uBuFBLtvoGr29a0gbz4vhZ9r4s
         Tn8TW9LUSWztXUOdQ8M/dwXP3f/NoOWZotCKENh5xgb84miKthmpfvmtJTX2NVmkBMdO
         FNxs11kNULWIMq7fv2yu0Md+lhZb0nIqQWfbjDUOFssTo01yI4EvAPyS55xJSFreLmkd
         A2f8ZB5mzh0PQvS5zRrVywlqjrGR5KQ3OcyoXY+BdXWWFBwdOY4vMcy+w6fmurg3IxYJ
         wWDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740732333; x=1741337133;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2DkF+HrYwJarAm+V6tPjIZWkJC9BCfK8Juksw+yULgg=;
        b=hWrUfhQGO2QJsmas58gKbK/gIAPKQVXOfcmiEZuMXUoKt1ZlOSIg3/vmxlffSdv1g8
         ZJJYIs2n2/GU3xGE+p/uS9tbo8oEHaKUzsGrNe5FFWVEKbp8UqoEiM+3rEgWLTM1op6C
         Ouzdm8LGHOMwC66DK1g9flO8ewkCi+lcVFHUzlgGanoL5rjE/oZhsJ/bNr4Am3tpqW5y
         LarG5eFB3PcMbCaJnyCb8VU80hvTTttasQlNqUOUHDY4crM4dj1fRgXzpvKoLjkt7gVp
         WZVVAbkiixJ2yXFhpLvPyljld5OGjBfsQJWaaLjMakkbp7GEfdS8FAZqwkTOpraxaMdG
         URgA==
X-Gm-Message-State: AOJu0YzWIz7hc2q2xu3qfbas6XB8fqYlryKs8nJ2ashL9xEb70qV7BI/
	ENXkS0yTggcVBuoUsh0gehTEr2pD8NeO+r85ZEglm/N8DnJ3mWRguUz41GVUjadX6yPR/1czWc3
	pr4C8qS+M2+ntey86caI6HfHudrqsWW58R4+FIwVQqY74KlehimXW
X-Gm-Gg: ASbGnct/g4qVWgR9moIaaSwSMfhlyoqsfxMHTy1FER8WktN+fFCwP7rYDesS7DwA+Z9
	eDVRzL0/Iqgn5uXQ14wdPcGCe3RzsYZHg5xZPTc5APJAAmM8I77MKBwKhcZoeqfVJUpiSiEB0Kh
	+YI1yWOWP8c/AjFhxyvIEeZHAHfUzfNHQULRV+bQBj
X-Google-Smtp-Source: AGHT+IF3KccAFbNAmIdkmAwC5sMLqFrfhy2tAN/Zq5E7/DJ7HuMVMld3uCqX1+JaXLjjLZkxTJEhV7iV+TBnrnOKokQ=
X-Received: by 2002:ac8:5d51:0:b0:473:8a1e:8410 with SMTP id
 d75a77b69052e-474bc056e2bmr27178551cf.4.1740732333041; Fri, 28 Feb 2025
 00:45:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228045353.1155942-1-sdf@fomichev.me> <20250228045353.1155942-3-sdf@fomichev.me>
In-Reply-To: <20250228045353.1155942-3-sdf@fomichev.me>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 28 Feb 2025 09:45:22 +0100
X-Gm-Features: AQ5f1Jp10t7xy1TOxQoWvNTwZa5iGmh8j5irAN_QTuKuXXFN96aDA3_cS0fqWTI
Message-ID: <CANn89iKNTcSpSVm4k3c9ZCbT0FNNAq8wmMxYXPKSfNYU=z7FTQ@mail.gmail.com>
Subject: Re: [PATCH net-next v9 02/12] net: hold netdev instance lock during ndo_setup_tc
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, Saeed Mahameed <saeed@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 28, 2025 at 5:53=E2=80=AFAM Stanislav Fomichev <sdf@fomichev.me=
> wrote:
>
> Introduce new dev_setup_tc that handles the details and call it from
> all qdiscs/classifiers. The instance lock is still applied only to
> the drivers that implement shaper API so only iavf is affected.
>
> Cc: Saeed Mahameed <saeed@kernel.org>
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

