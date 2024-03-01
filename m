Return-Path: <netdev+bounces-76596-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0F286E56E
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 17:25:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9164A2879FA
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 16:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A834B73184;
	Fri,  1 Mar 2024 16:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q2DlQAsC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D260171723
	for <netdev@vger.kernel.org>; Fri,  1 Mar 2024 16:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709310264; cv=none; b=nyNHmgtJSfl8m3fIMO3UbujtDrbQH9GvDoo4p9J0GJsI+sZhoBDKRE0zY6AsjskIaMn5KPDqFBWxh5DzPRrJmg/pe0eX5dsEgj8I40WFtExtlRZW4kNpLMjwxL4QpHqhkN6qP8WCKeOlQpYaJ+MAEMelWsKQVtt0bqSmtx7Hf+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709310264; c=relaxed/simple;
	bh=JbldwAtTNrdXdciqQBqsHbLDwNNz8QFF5ynv32RmltY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GaG7GPDMPm0Y5xehU2AnsAjfvtklpce38o3nIPJy32AbSYDSkfXw0s5cRbk2/hRVAjt0iULI2zgII3VY51HJX7YCiBsNw+md4LjsaKQYIb2qGtuumAOPDi4JGlqmsvTPvfwLa/muJfU7rdjIRdC4zjIRf5yEYVDbdbumsIhwrK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q2DlQAsC; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-565223fd7d9so7945a12.1
        for <netdev@vger.kernel.org>; Fri, 01 Mar 2024 08:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709310261; x=1709915061; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JbldwAtTNrdXdciqQBqsHbLDwNNz8QFF5ynv32RmltY=;
        b=Q2DlQAsCdXaTkI/IFP/zIMOBTQJXWopMrz8++1fNfgoLYvXBS9vOEKjtg4WcoydywU
         SJK0PTgmCbwMT04v/a+Ea8m2qaxgEugFW/cK8ZsDgUDK/XsaOZMFh6qFf87stYhAh252
         tGIEKp9mIADMxAsAsH17mhKhygdbcaW/xm3nBOQRFOH70kObXt6TLQ7sI6l8MRZdz7zI
         WnNq6He49HJJJm+lnWKH6PHuzFuG7eOVY5ZTLCTEezwEbCcvylmzHc1GwTnrOxKRXeXq
         EbvNx+1qV79Xy6wYksdVwJTYpdtcihiGrNGW7CncbOjAcuwwK6mckxuz0kH5mwrDbyE2
         BnJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709310261; x=1709915061;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JbldwAtTNrdXdciqQBqsHbLDwNNz8QFF5ynv32RmltY=;
        b=itKwpmx5apC9EtWiRaYCR1VsSLTf6vMd3r6fdv8fhryjvzcmxVyKqSTabvHV8cnmrY
         9u8wk7nq19w+cj12PXSGAHJnI9mHU5YaZ4nUKO6LQ82HgsTzp/Qh3InapHZdpu4VlRGD
         ztyseXcYfleNqd5phRS7V1qzxdcWW62fDuwUoCCNY0QFSp0igeIclwyG1wUwe2v8Qi4Z
         HlzlAxoCK0HwIywuAsjNuxy3dcSGNPTsPsuYFbvCUk2T65V4H6tGVMCKbK97wbzKEO32
         MbSxVC2dx+WCdrrd76Xif9zPbFDCPbekvujVBIjawf5JxGO5MIjYHAk0mhHjrnTXubwu
         /irA==
X-Forwarded-Encrypted: i=1; AJvYcCVNHOPQ+q/WH7ZtrQ2abOraHHv4uhscuOHI93cqamPtNIdMzpjwsPO+3CH0DAiYQnQvhSTU3kJpZpER1Sm3bqqwzxPldNko
X-Gm-Message-State: AOJu0YzRdGCpaJMsbgj3eoyRPo/suwCzpGAC3dr3FW5ayuIRxiAAzAe/
	S5MKnLqOHIqWm6R0T6OYc3ou0uXDl46e48kP/nkgYCEvppB6i84kjawOpJEa57toYUlFUnRrJmB
	/SB59pla9xCHj51ehwVTDujImkQFZ0kwLvvrBbRvW0OuyKXOnCA==
X-Google-Smtp-Source: AGHT+IGIgyVyBs3Ou7ZSB7lbjeCL9elrPBAUAYl1tAyTI+Bm2e4e9i25q5rXIGID2Atmb48ROfgkLE1K4EdgOGgMbZQ=
X-Received: by 2002:a05:6402:5215:b0:566:f626:229b with SMTP id
 s21-20020a056402521500b00566f626229bmr10150edd.7.1709310261006; Fri, 01 Mar
 2024 08:24:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301001607.2925706-1-kuba@kernel.org> <ZeH26t7WPkfwUnhs@nanopsycho>
In-Reply-To: <ZeH26t7WPkfwUnhs@nanopsycho>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 1 Mar 2024 17:24:07 +0100
Message-ID: <CANn89iLcOE7aJ6SSjCSixLOQd4CsMdmE1UQZWBsp6UgufA2pwQ@mail.gmail.com>
Subject: Re: [PATCH net-next] dpll: avoid multiple function calls to dump
 netdev info
To: Jiri Pirko <jiri@resnulli.us>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, netdev@vger.kernel.org, 
	pabeni@redhat.com, vadim.fedorenko@linux.dev, arkadiusz.kubalewski@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 1, 2024 at 4:40=E2=80=AFPM Jiri Pirko <jiri@resnulli.us> wrote:
>
> Fri, Mar 01, 2024 at 01:16:07AM CET, kuba@kernel.org wrote:
> >Due to compiler oddness and because struct dpll_pin is defined
> >in a private header we have to call into dpll code to get
> >the handle for the pin associated with a netdev.
> >Combine getting the pin pointer and getting the info into
> >a single function call by having the helpers take a netdev
> >pointer, rather than expecting a pin.
> >
> >The exports are note needed, networking core can't be a module.
> >
> >Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
>
>
> >---
> >BTW is the empty nest if the netdev has no pin intentional?
>
> The user can tell if this is or is not supported by kernel easily.

This is a high cost for hosts with hundreds of devices :/

Was it the reason you did not want me to remove zero IFLA_MAP ?

