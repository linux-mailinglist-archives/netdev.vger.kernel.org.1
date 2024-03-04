Return-Path: <netdev+bounces-77095-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8608702E5
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 14:39:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFFFA1F269F4
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 13:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E9263F9E7;
	Mon,  4 Mar 2024 13:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NvDyxgzk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E0D3F9C2
	for <netdev@vger.kernel.org>; Mon,  4 Mar 2024 13:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709559545; cv=none; b=I8CoiEWuhGaUbBWQw+oa8J3imBhnw9lKbhzwLOYsM5rwr2aO5bGdZUZ7jSyURHD1Mg2NJTxbCvtjqtqNAw7P0Wmvnz0R04IJHvrp4d7e2q2lPMf7lJ8h53+L+BM3ifNSHDNTPFSDKbLnLT916BCh4n/x0YpHtk0IHY4ht54ZuIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709559545; c=relaxed/simple;
	bh=Utp7sMlXkR1Rhlg1oXlfu09zINWNqAAiyEDBq7R8G8w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BbIy+l+G+RM4AlGoaJW24mkX08/B12Yb7qxK4nsP8COjILkWRxkRqrU4LmEhPe2KrbTSuWLFuM0l4xJ22MXyZtHTTE+gl++JlA81yDt9d/VMNMWtvsydeZsv54PZ0bT5+A3/OnGKTySwBrpn8ZMsid1lhhJSF6bOcs+EavwZLB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NvDyxgzk; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5a105e55bccso1681657eaf.1
        for <netdev@vger.kernel.org>; Mon, 04 Mar 2024 05:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709559543; x=1710164343; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ipLp0J2g0W5A61oKLbpF1CgtNEv/F767aFWvfPI5oTo=;
        b=NvDyxgzky4MHya05YB157AQAhc9xJsIZPy5ZpqKc6hI8GlaeiLOKwQ0i8LrOqvOkXP
         5HKZ+iu9jqkntlDmWjPgp48ZLfkaCYBaQbsQlEsF9kQ4HXdfd9vKORh5V3uosZaTeyTl
         5CZWGkxTwy5tR7pSVRfknaSWdxEGEO6DFpxzYGQeon9sfOOjOKQGylcICUK9cFBrHxnE
         0BwDsDjwMW/btbxYdbK4JR+gKGHvTYg1gFPGXs0NKwdjId+XnJFmcZxWcnSNsggddgKD
         CdyJzTJx/ew8FLZO6JAlmVcy1ePzETc562aZVtfXsv6tPwEnndhKra01Jh3OW0rQ0htg
         W75w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709559543; x=1710164343;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ipLp0J2g0W5A61oKLbpF1CgtNEv/F767aFWvfPI5oTo=;
        b=Mei7sZJz4AM7bYkIv23cqo8wv9jVfM4VjuE/LozC/bVxTLqOmupb29AK9ieClodmY9
         35tp3snhfAh4oHsuE+b6fAr4x/srFpj2tR9KycEwoXJvQXrnvrSwct13N9ENPZQxHVkC
         7mgVC/HX78qjrkOujpLzXwAYPg5pXzZlvqvumL4q/Lw8f7TFyJHJSO/CZ9DA58JCvhiy
         fZ7d6BAulH604vQngg2NI/4HuPqdhkKQV4s6KuMX2kWpNnx2L53tl3cYXHYFSiavpwdq
         wefExuc2IQ3DXuFeXi9i1deIcVqH0ePwVdAOnNRor/sECJ0NM9vTcAMJb3O+Jm6oMFgU
         Z/kA==
X-Forwarded-Encrypted: i=1; AJvYcCVLHe613ZFk37aAU5gK/xpvUZZaJFfd9S+xAlnXxJuv3xT7ec6P9n69bMEZcDh6Zp4shMLdSWKz1IVI+h/IJmWLuEicygk3
X-Gm-Message-State: AOJu0YwSpizfMgRXj0zvyVi6GPdXgJCvJb04kMxsmLg7HuV2fq6dv9ER
	Xva7Dlh/X+xUMqtnYDDh+AAh8oWr5ti4yp8tHKxc0l+3gGKgl2xnPQA/80Q/qIWJ/UpCOlQX0mk
	6XWdcN2nOpEAZ1sbra8B/+RmmQcI=
X-Google-Smtp-Source: AGHT+IHmhJwnRLWXtixKyQnvYvKi3+Y22+375rZRv4PJFfZkVekADKcrnPcYgqRVfSUMpthoHgHGKwTOPBxgYNSazq0=
X-Received: by 2002:a05:6871:4396:b0:21f:6d8d:67a1 with SMTP id
 lv22-20020a056871439600b0021f6d8d67a1mr11227638oab.7.1709559542894; Mon, 04
 Mar 2024 05:39:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301230542.116823-1-kuba@kernel.org> <20240301230542.116823-3-kuba@kernel.org>
In-Reply-To: <20240301230542.116823-3-kuba@kernel.org>
From: Donald Hunter <donald.hunter@gmail.com>
Date: Mon, 4 Mar 2024 13:38:51 +0000
Message-ID: <CAD4GDZzkVJackAf2yhG1E5vypd2J=n23HD5Huu356JK1F1oLKA@mail.gmail.com>
Subject: Re: [PATCH net-next 2/4] tools: ynl: allow setting recv() size
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, jiri@resnulli.us
Content-Type: text/plain; charset="UTF-8"

On Fri, 1 Mar 2024 at 23:05, Jakub Kicinski <kuba@kernel.org> wrote:
>
>  class YnlFamily(SpecFamily):
> -    def __init__(self, def_path, schema=None, process_unknown=False):
> +    def __init__(self, def_path, schema=None, process_unknown=False,
> +                 recv_size=131072):

An aside: what is the reason for choosing a 128k receive buffer? If I
remember correctly, netlink messages are capped at 32k.

>          super().__init__(def_path, schema)
>
>          self.include_raw = False
> @@ -423,6 +428,16 @@ genl_family_name_to_id = None
>          self.async_msg_ids = set()
>          self.async_msg_queue = []
>
> +        # Note that netlink will use conservative (min) message size for
> +        # the first dump recv() on the socket, our setting will only matter

I'm curious, why does it behave like this?

> +        # from the second recv() on.
> +        self._recv_size = recv_size

