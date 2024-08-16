Return-Path: <netdev+bounces-119293-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B2195514D
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 21:19:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E4ECB2130D
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 19:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44CDB1C2302;
	Fri, 16 Aug 2024 19:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dwwpND6K"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF21B8120D
	for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 19:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723835990; cv=none; b=omFwhe4QcqJ40xa3HB6X/++Yw3zgIrbEX6RGvW0krBEpZjOJtHLp1iKqEiQVrB59G85VkFWMrFxV2TW7EFF5xj3KB7AVnsOh4zLRJFwTK9BkWoc3utauSTqYcEACUnA/oOkHdXz/LxrukyqBwc5xZHFzmDUe2ibAiEe1WvQNPLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723835990; c=relaxed/simple;
	bh=Bwl+NjL7KPTkB1ko26pL/cqlrCHYYzcURB3nHJyR1yk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=M0arcI6c6uw0VR3R8mAYtjy4unnUaWlQX06TcYKbMJTJTqhjQupAOTn91ip7Soq+fr/DLVmkLC6MwdnyKTmLutIDJp8E7g9ChXClmUjbmw33j1Yipo8f2V8v7eDXic+9n+2UZM5fgcotuHdwCwTrhIlG3ivfddSWVnJG8UkmpKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dwwpND6K; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6bf7658f4aaso9308106d6.0
        for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 12:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723835988; x=1724440788; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qt4vIh4aTpUxGW3I1m4FaLLSxIu9SqarF0tt/g0gNAU=;
        b=dwwpND6KMb94506j7iDtaPqZTwG02KhuDFUhWL/w5LRIETTfscItkF1vadhJX1ptrV
         a7HoPA0TymnoKU74eEqUAJQAcWkSARDbmCl3bbbIr2iPaTWGAErFZov1g5R0hwhrVZ/+
         G+RwGqkblxeuGkG8+wcgMQoDjc4zUVDhQZJWG92kDomiQEbcXgOIV+cde2y9jtX+HGua
         kFvZDVmyOSd/Fr8A863f0a0ud0MXOg1dJUDfw6WpTckmWu08CVN522rWIGyXz/6c5+FX
         gKJ5eAtOOxFdNpOn3MY3d8gfGshg6RirjAo/ZHmEODYpknPXKNntnA/kFK6TF4bEDHzF
         iLFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723835988; x=1724440788;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Qt4vIh4aTpUxGW3I1m4FaLLSxIu9SqarF0tt/g0gNAU=;
        b=tZWCP/v+UqF4MIjh9kIM2STOl+RRxiWfsPva1mXP3gq+EDWtS3H+IVwCdfrpCBJXK8
         a5vZVkl1xiKbrkK1hJsfgI+RwM4HDi893qYvftX8fmhku79AzCo+OTDau0XYTyvIs33n
         35hV6v3KBp68rKEtkdQUKnKM5U0BHL2R8bHMG3QOoqksh0qhwn0NAvlJxRFrTckoFx3c
         40/cIpX3AWSPCXtJX4cvGFtnGhHYglWfn7HnRno6VYHe0p69qXM+7FcNb6SF0rRBb3MW
         OQdxYC4qRwCRDv1VwbB3CyQ96dS7q+riR0UYkVOTNaIs+8Rc1VoZwxAKAolEHwtj8V1q
         47Rw==
X-Forwarded-Encrypted: i=1; AJvYcCXmEJBOBpJiFJp7EBOkksvZT3ZarpGaA2xWHZDZc62OFBMH3nWsK+oJBXkCgTCQjsJUuAlcKV6hxsk/QNofpczmQd+ZouNK
X-Gm-Message-State: AOJu0YxZGuuj7Y2TbMqJ1w536qBeix6WQgeeicFPurJXqx88LVC8jeye
	aOGkZvXUhhmNqLSrJ1TDd6Pecsnj8CqxB+jmFiY3m21A4JuuTPU5
X-Google-Smtp-Source: AGHT+IH+lPoalc6/tX9WJ9uAXcgUSIFZRVheY5a5z1R/dFDhxiHu2l5Ka331VVXZ9LcA/+EeIn7SWw==
X-Received: by 2002:a05:6214:524a:b0:6b5:149:eac5 with SMTP id 6a1803df08f44-6bf7cd99968mr45351866d6.15.1723835987607;
        Fri, 16 Aug 2024 12:19:47 -0700 (PDT)
Received: from localhost (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bf6fec7eaesm20947116d6.92.2024.08.16.12.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 12:19:47 -0700 (PDT)
Date: Fri, 16 Aug 2024 15:19:46 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Tom Herbert <tom@herbertland.com>, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 edumazet@google.com, 
 netdev@vger.kernel.org, 
 felipe@sipanda.io, 
 willemdebruijn.kernel@gmail.com
Cc: Tom Herbert <tom@herbertland.com>
Message-ID: <66bfa652a0da8_184d6629466@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240815214527.2100137-6-tom@herbertland.com>
References: <20240815214527.2100137-1-tom@herbertland.com>
 <20240815214527.2100137-6-tom@herbertland.com>
Subject: Re: [PATCH net-next v2 05/12] flow_dissector: Parse vxlan in UDP
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Tom Herbert wrote:
> Parse vxlan in a UDP encapsulation
> 
> Signed-off-by: Tom Herbert <tom@herbertland.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

(not very familiar with VXLAN)

