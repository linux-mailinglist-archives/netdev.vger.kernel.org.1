Return-Path: <netdev+bounces-235564-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9794EC32700
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 18:50:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59CFC424230
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 17:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32767339B38;
	Tue,  4 Nov 2025 17:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ugPQCSCS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4CF7DA66
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 17:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762278481; cv=none; b=A6xnivQyjYlkM3cRqhhEoUMSbUMrZwzfrnkc851JCNkWsa6LKicJCR2o2K5jilOc6g2D5YyP4LNFHWgh8Q/ro12wwU9j1KTqlv3bzN9+66CuQ/Tij/2egQDEr/amLS8Ggo6hWcRd/01zZ9v0dkat8y7tt7kL1nMqzKXnVKr3MUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762278481; c=relaxed/simple;
	bh=naZDWD+jXe2RTykUsxPPBYLTaOHt15sOSQ4dJwHulZM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PSYWkzBFF5wMaq8poneqgfYe4M1rQ1NmxBVN58B6pCXc7C6LhHQQbhdnKpMXUNAiWN66MnS4op8oDmlOe5bV2jwb5AjAl3Q4btkBlsd7smVrmNqT5rBxkCN64djE7J2qJNA27aYG2fcbHLivXfY1ib0cM2SnCeg1oSn3X1LNeN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ugPQCSCS; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-640fb02a662so169a12.1
        for <netdev@vger.kernel.org>; Tue, 04 Nov 2025 09:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762278477; x=1762883277; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=naZDWD+jXe2RTykUsxPPBYLTaOHt15sOSQ4dJwHulZM=;
        b=ugPQCSCSXojk6KFtAa99RlQNpQhR/iSiUJkjX+ysoYt7kmvj5TjvSYZJf7X06XbckA
         M/P7ERcol8+OFYvX+8af7Bc7UokUG9fiMbc74rThA1q6LZS6e7fRwHzNXdO3Lh8o6Qe/
         PNBbQIjYC4vMqOx9xl21aIw60Oo8KPnARIG1F6GPti9POO4CI3GjhSj65PQiqfaRtSCH
         l2ovvTL/ClDlnYQUn0Aj1Cv5t9kCb4Q9ZCnJllJNePRFgnfMCM6sVFv/ksI8IQDREV1S
         DcUhmIFr+veFz/g/Xj9LOt5aXpLIMM6DJUooeXCwrnZJP3bTjkSXgrLUZeYxi/grCIHR
         1Scw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762278477; x=1762883277;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=naZDWD+jXe2RTykUsxPPBYLTaOHt15sOSQ4dJwHulZM=;
        b=aXxvNhwMRBAhP86DzM0FssH0fxPwnOlwMP7OrcYE7DdqOuOQDz8dpZYJe7+LOMnrHO
         HkJjlcKhDF7xlNG3zt7uizfNO7iCeF+wECRAPS1TgmDBBvCrwGzsAlA3MH/F214wgNh1
         eOSh/ZK7ZGx0Y+lg7CtIJshhhIcDlR4yLIUQ2gEWPMn15zVMopZqC+XdopM9bKswD7TI
         P5UWRasH5ED0S+3mkaZllfzRMXUiVPo76CRSeWdkw/piws0HCFL3eCml0JjTSSZ3Z0DY
         soq+rGXbZ4fyQV5lEB6/qvMItWPXmSEwxvM+3ftRGNAj6YDSoM1OqKrY48hnfj/o5agO
         zY3Q==
X-Gm-Message-State: AOJu0YxEDLlObn/ELbmPjXQYXKVcPelLrC+QfUCFTlwiLc6rA8a/y6+H
	jSTrrhO0s7ZUiqiXe3I4wPnBDygFoLOi3DnJA9EH3qjG3oa+5QKDLhNu95oP0heoe1kLmKgXrih
	suwy4xvRSeCJ8kIBq6I8u1OLDn5QV8fWrb+0UxT7B
X-Gm-Gg: ASbGncuhLKRp9hP91vGoswp+fYgKVVFKiEsYMaapraZIjvByRBbR/AXWF8cwi2sRdYy
	6WOf6X2aqRXiGSOW59m5/cuSQFfnhnZHATQZWHjByD+RzXUWegODMvka+4NFRU4n3hvICUu+GOO
	qlOOo+zkU8tW8v9I5qAOKOODARRnPhUI7Cmfy7+o0NcRC1jsqzvfzeCx323LFuFN67MPewlxo3b
	xNSa6SMnG30tHHjfS4xf8OFvv0wj/soqEBfu7PPTfSiOLk2Nopy1tGp5zrh9NvG4tkMhcU4VMMW
	WaYIothjw09MDsPB2jHc0lLAxA==
X-Google-Smtp-Source: AGHT+IFxVdvZoaaboVMnWhHpGqiOgxBaCtl8Wdw4aZprlhirqeuesq/cXrOlHupxbHqRD67wfy6/JLS2mKLwz3kVBAY=
X-Received: by 2002:a05:6402:d5c:b0:63c:1167:3a96 with SMTP id
 4fb4d7f45d1cf-640e9327aebmr121052a12.5.1762278477045; Tue, 04 Nov 2025
 09:47:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030180832.388729-1-thostet@google.com> <c8b2b414-149b-4f35-8333-43011804ea2a@linux.dev>
In-Reply-To: <c8b2b414-149b-4f35-8333-43011804ea2a@linux.dev>
From: Tim Hostetler <thostet@google.com>
Date: Tue, 4 Nov 2025 09:47:44 -0800
X-Gm-Features: AWmQ_bmk1rluEW2OlBfvkjh-u6qvpegsGbFrmPmMfNLljZ4WeLV2baWrh6d4TPM
Message-ID: <CAByH8UtTVvLQwOe-ieyfvdFUnLz8X11b_ipWmbNhGkAZAXWfOw@mail.gmail.com>
Subject: Re: [PATCH net] ptp: Return -EINVAL on ptp_clock_register if required
 ops are NULL
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: netdev@vger.kernel.org, richardcochran@gmail.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Kuniyuki Iwashima <kuniyu@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 3:32=E2=80=AFAM Vadim Fedorenko
<vadim.fedorenko@linux.dev> wrote:
>
> The patch itself LGTM, but I believe it should be targeted to net-next,
> as it doesn't actually fix any problem with GVE patches landed net tree
> already.
>
> Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

Thanks Vadim and Jakub, I'll spin a v2 for net-next and fold all the
input validation into one WARN_ON_ONCE per Jakub's suggestion.

