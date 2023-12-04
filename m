Return-Path: <netdev+bounces-53560-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67194803AC0
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 17:48:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A3901C20B65
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 16:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A60225764;
	Mon,  4 Dec 2023 16:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bNXT5EVC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA81136
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 08:47:26 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40b4746ae3bso42336555e9.0
        for <netdev@vger.kernel.org>; Mon, 04 Dec 2023 08:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701708444; x=1702313244; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=99jopFOR7BoMUDv+uMH0BdR7EEaJXf6zFk0M85hRs6E=;
        b=bNXT5EVCRg7i0gvwdOxvF1E0trxL/1icWXuLT/ZysRa+0xqau4p4zZPMjgzExrJLwl
         xQ0+S4DakB3T8dsg0xprCo9E7nKIgGJyOTYREcN4+9zCB/azxK1yAbF7W2GhTFp4ZB6y
         KQ8+HudDAYqPQHg+Up0pv97WjxSerZNxhn3shAkKIjTW/sSGNeZICJyDJxY0uST3I/5g
         n5w0heWPkvvTArW0MFXZsyjOpf+eNcUjzCu74VpPUEadF0c9G+XbdIfOoddYD02wuSyx
         QTsI5bMmIHPe/5AIroz+5jMX6eqZDvmPrXKxk66ICZHfeRjc5m0NITrzFFhKP8hi35mA
         s53A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701708444; x=1702313244;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=99jopFOR7BoMUDv+uMH0BdR7EEaJXf6zFk0M85hRs6E=;
        b=L34cV7ACAo6i8p7BxY+5R1JjqbOANBMiLHDWtq5GqhvgxQtY4bRLmZvmSN+7AFC6mL
         qHr6uquWjiIoAKadA7O4mTIWwpQw1r6JpzgP/ggtyL8lRdZ9z5EQ2GSb4BsLaCXhNF8A
         7GFw76YLgzIcSDVfAlH7X6uCxpUbPqsmzfbODPUn+LYUWJUOYti1CTGQhrgdg5xw5WBD
         w6SlzUQTdPFaziGTlBIm1P63/eHBOaEo7Dx/mMWTYygn/cibWLCv9wB8IgRt0rUd9EfO
         r8U0QGKxd9dV46po/1mq5SyYRQfndFpZ8ZxC9my3DqLNLgEddjGNzHjGJcdYQIwKFdy6
         m/Hw==
X-Gm-Message-State: AOJu0YxVJ9PhLB6r5eSiEHh//rn+CvIJnuR41lMOKoBCc7oLANXqWYC0
	WmfSELSc5UfKfgcqfXEmBDA=
X-Google-Smtp-Source: AGHT+IEB+BdAZiOqYumwJ8/61pdqLKn7fJdhvzAc587Ceqd54LqznepjjM4Gx/ZXcpvVVo0MVhBgug==
X-Received: by 2002:a05:600c:4453:b0:40b:5e21:cc14 with SMTP id v19-20020a05600c445300b0040b5e21cc14mr2694424wmn.63.1701708444267;
        Mon, 04 Dec 2023 08:47:24 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:d9c9:f651:32f4:3bc])
        by smtp.gmail.com with ESMTPSA id iv11-20020a05600c548b00b0040b4cb14d40sm19329720wmb.19.2023.12.04.08.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 08:47:23 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,  davem@davemloft.net,  edumazet@google.com,
  pabeni@redhat.com
Subject: Re: [PATCH net-next] tools: pynl: make flags argument optional for
 do()
In-Reply-To: <20231202211005.341613-1-kuba@kernel.org> (Jakub Kicinski's
	message of "Sat, 2 Dec 2023 13:10:05 -0800")
Date: Mon, 04 Dec 2023 16:45:46 +0000
Message-ID: <m2v89d6hmt.fsf@gmail.com>
References: <20231202211005.341613-1-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> Commit 1768d8a767f8 ("tools/net/ynl: Add support for create flags")
> added support for setting legacy netlink CRUD flags on netlink
> messages (NLM_F_REPLACE, _EXCL, _CREATE etc.).
>
> Most of genetlink won't need these, don't force callers to pass
> in an empty argument to each do() call.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: donald.hunter@gmail.com

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

> ---
>  tools/net/ynl/lib/ynl.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
> index 92995bca14e1..c56dad9593c6 100644
> --- a/tools/net/ynl/lib/ynl.py
> +++ b/tools/net/ynl/lib/ynl.py
> @@ -705,7 +705,7 @@ genl_family_name_to_id = None
>  
>        return op['do']['request']['attributes'].copy()
>  
> -    def _op(self, method, vals, flags, dump=False):
> +    def _op(self, method, vals, flags=None, dump=False):
>          op = self.ops[method]
>  
>          nl_flags = Netlink.NLM_F_REQUEST | Netlink.NLM_F_ACK
> @@ -769,7 +769,7 @@ genl_family_name_to_id = None
>              return rsp[0]
>          return rsp
>  
> -    def do(self, method, vals, flags):
> +    def do(self, method, vals, flags=None):
>          return self._op(method, vals, flags)
>  
>      def dump(self, method, vals):

