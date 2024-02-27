Return-Path: <netdev+bounces-75421-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E78869DDC
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 18:38:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF64C289B5F
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 17:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB5904EB3A;
	Tue, 27 Feb 2024 17:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D7Z22n6q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A58C48CFD
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 17:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709055428; cv=none; b=TQFmfnpPZiZXF7FfB8n9AjyVqHajgfqBOX4IE+s4t0VemPdT8lHxVluGXqx0oJj5aJeiz/RUk/tNcdDZ4cpYhygbHpWCYvzTYHiTdQ9T6PEF7RYc+lWGluCXxUZbrTWBq/31vxMFzDTp5bXDI2/62UfJjtGnmwB7FhZHU2Upnks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709055428; c=relaxed/simple;
	bh=nVNGmVXKAEOKDfBgj9V39hIzSeV7feKa0MgwLf5C1dU=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=krv3wqLtqKqzZ0FpeQPM6/NkmKvapuxY9DsiA4EslD/tlRbVSri8nUWOONpInm0ga8hzokuU5TOEdgOEn6196NxYPqhec/xm/eHj7hHzJhvttLjOI43xW7EhPRzAi7nqhuUa4mSros2NqSeFZp7CdaNCvEYqbRfqWYB4ceonbEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D7Z22n6q; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-33de6da5565so998308f8f.2
        for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 09:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709055425; x=1709660225; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WI8byUdnwun8bYNZ5ZFPst2nXXzQcCfO+bTT2OtGD4k=;
        b=D7Z22n6qbBr8lQedmALf9gbYhvxudhcyAvfF1i85xdQi6VQsMSuWmQkpjLdKDZkilI
         q1VJn0gmXftV+c40Dr0rDwQiLo01gxfrpczuMfPOAPZEipyVvIvGBJpOfl/jLvWUz+45
         eAGpunzu/7Sw5Xt2JpuM7WcRcQ7+HO7W3ozBaglHE1cbv93lm1QCei3UEtip+//befR/
         zhgM/s4VbI72noctTEjIf+k01cnMhLMPalTF+uViAuLSAo4svOIaC/StIEWUG41UW3XK
         ZhGblE7wuhtdL9H0y97EueDDBEvOWmXHCLG1XyNIx8JEoUHKlXeTFECvDOOU/MrwPpbq
         cxeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709055425; x=1709660225;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WI8byUdnwun8bYNZ5ZFPst2nXXzQcCfO+bTT2OtGD4k=;
        b=G0DKlSP/cIDYAo4WgxCcHwKI+s0vMNNduDUrDmm2on+pnog3RdfJeO4+Tiac3Tif7s
         cETFYV5HpDrZYN5I90PqRHlM/4pV2gq4zb2U0aobEg6+J1WCMk00fSzqH+pbFgH8DzLZ
         quMY/4K+C9EZ03UM6it+Djq7nxVcqIKYvW/MOAXb1UvzOc/f9KyeVOXDlPwq9bdsbvZE
         p6GPdEiRkcvknp1HCnHr69nfgUaJYU30OvNSbxfXq5mx+g8BsFx7NoutoCle/fgfxPNm
         mOPtA4ZXn7ju1TlPvkty592qR8v0nLEHCgwIQWpqPY2eUI3wIXkA9GO/mCG5P43plXUm
         OP4Q==
X-Gm-Message-State: AOJu0YzI3dxccmhqdVT2K6QM9YkBpAHVFGbkd1ywqQWdcgyqhxsnGosz
	4q83WT5Ys64xIZaUAbL14LkpR5uYbWFL2SuFU+lgT2vzPpK1h7m3
X-Google-Smtp-Source: AGHT+IEx3NkNQXa8bqru+44JyDMIq0RFaZb5aqANZXGiZMlQNo/4yA03NEXYGuiKcKpq3rErhyFTaA==
X-Received: by 2002:a5d:64e3:0:b0:33d:862c:1598 with SMTP id g3-20020a5d64e3000000b0033d862c1598mr10365663wri.50.1709055425175;
        Tue, 27 Feb 2024 09:37:05 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:58f7:fdc0:53dd:c2b2])
        by smtp.gmail.com with ESMTPSA id d24-20020adf9b98000000b0033dedaee5d5sm2656471wrc.30.2024.02.27.09.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 09:37:04 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,  "David S. Miller" <davem@davemloft.net>,  Eric
 Dumazet <edumazet@google.com>,  Paolo Abeni <pabeni@redhat.com>,  Jacob
 Keller <jacob.e.keller@intel.com>,  Jiri Pirko <jiri@resnulli.us>,
  Stanislav Fomichev <sdf@google.com>,  donald.hunter@redhat.com
Subject: Re: [RFC net-next 1/4] doc/netlink: Add batch op definitions to
 netlink-raw schema
In-Reply-To: <20240227091348.412a9424@kernel.org> (Jakub Kicinski's message of
	"Tue, 27 Feb 2024 09:13:48 -0800")
Date: Tue, 27 Feb 2024 17:36:29 +0000
Message-ID: <m2msrllsgy.fsf@gmail.com>
References: <20240225174619.18990-1-donald.hunter@gmail.com>
	<20240225174619.18990-2-donald.hunter@gmail.com>
	<20240227081109.72536b94@kernel.org> <m2zfvlluhz.fsf@gmail.com>
	<20240227091348.412a9424@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> On Tue, 27 Feb 2024 16:52:40 +0000 Donald Hunter wrote:
>> > I'm not familiar with nftables nl. Can you explain what the batch ops
>> > are for and how they function?
>> >
>> > Begin / end makes it sound like some form of a transaction, is it?  
>> 
>> Yes, it's handled as a transaction, containing multiple messages wrapped
>> in BATCH_BEGIN / BATCH_END in a single skb.
>> 
>> The transaction batching could be implemented without any schema changes
>> by just adding multi-message capability to ynl. Then it would be the
>> caller's responsibility to specify the right begin / end messages.
>
> That's where I was going with my questions :)
> Feels like we need to figure out a nice API at the library level
> and/or CLI. That could be more generally useful if anyone wants
> to save syscalls.

Yep, I'm probably guilty of trying to put too much into the schema
again.

From a library API perspective, it'll need to take a list of tuples,
e.g. something like this:

ynl.do_multi([ (method, vals, flags), ... ])

As for the CLI, it will likely take a bit of experimentation to find a
usable balance between args and json payload.

