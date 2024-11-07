Return-Path: <netdev+bounces-142784-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3239C9C05B2
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 13:26:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB0B22842FB
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 12:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 545A520371D;
	Thu,  7 Nov 2024 12:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lC3RdT/v"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC93200B93
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 12:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730982375; cv=none; b=TzvB88F4Ti+rM5/eLJWs4wa7gMqMZTLXzpnuoneGTPJmidyOqUy66F/SYCpE7e6vr1gXSjTM/Eb0tpQ2NvtJQG4G62zI+vP8V2ZYXrtSxo9ORSuXrN8Y1aNGCT0dw6c5KqsUDXyP7wM1MnjmWGn790cakaSqLWClMKJF9lHps2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730982375; c=relaxed/simple;
	bh=5zXSMHay5lN1TpbYNJto8uojGDIwvumMNYSmtiNSyHk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d7xb3aB0K6xl0iGurYVh3VyXca8wapmRJtT0d3wPNgTx8yWbWj+bCO8NtXC7BXJD2k2cXTq9De2dXR8xH+WeiN5NeZ0rDO6BX+Cw6DACd8OYP3o+1Xnph+BlgJ6k4vyMtda1/zkqvupsuftxCkfoPvQfnmb5WKFBhvGRzn4WG6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lC3RdT/v; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5cb6ca2a776so1313979a12.0
        for <netdev@vger.kernel.org>; Thu, 07 Nov 2024 04:26:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730982372; x=1731587172; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5zXSMHay5lN1TpbYNJto8uojGDIwvumMNYSmtiNSyHk=;
        b=lC3RdT/vx73nvPLY9RrKtKmAj8PQeQpTJ683mRbVWmwc/A7d6MU03hJ0QJ+6e1JHVn
         q4TB+wKxYSEWuXYJNbb8og/PXV4bkmU9BfdcF8fDqyi1Yj2Cdx4wGbsMTbzXxcn34Rwj
         tmoBpkZKX7GKU1kNx7P/aUdUK6Yfvw2FE2M4Qr8Gx8CO0IQwGHL0WNxUV9yB3Pxn2Tz+
         ke23Sk6jQfb2rUT3u62TZXoj9oi+r1o21pfYXRq8+0p7k/oePN8Jxohj+DO1nz3bfcdE
         jxCRs95te+9+nrkKg0tWjxtgv5Phlf2FAFvFoaPTSTdr16x4L3EX1ZIHuIrV5DIYNJ2f
         LkCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730982372; x=1731587172;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5zXSMHay5lN1TpbYNJto8uojGDIwvumMNYSmtiNSyHk=;
        b=gsmlpvEHxU+2AXN5YJUQ2j78AUKXWwHK89OyNyOQ7Jfdk3Jo1/MGIWjm3mmwkVFeq/
         n6ruIl6tlOBt2zV4Eymu/wBOx8/be50JHhXIySXLXgG1MEqueMyVI1Y9lh/dW4rYNOCl
         FBUCuAJ5L9BSX1N026sXT30Qwuq5LTCKZWdNJau3uXjeY97DyFPqHQR//dxQUELsCZNk
         +Ses8+6/foiUp+bq6YIWZIqEC5r499luadJrGavDrl+WZ/wvmFsJRO2GJaj1gslRdoRD
         N0pkdwOPGvoedbC5v/1wolB/h9h2oeZhDruvJg7afa1GPsIsFVrWZjTWMhmDqZH3H6AB
         YG3Q==
X-Gm-Message-State: AOJu0YzOec50cFejHEFNbuq73zbUuzPBTgMO0kXEHYVY+CJOG7Cel1wf
	4dxDhfhEapUHsTNax69AwUWLvlhYXCpypqWHxPvhmlmXpKDfLwurQnRiKbYEWe9VtrJtOkfmm90
	GID8SRkYuF9CeBwjSXqaUOq2fZEzwOj6o4FDB
X-Google-Smtp-Source: AGHT+IGVPMRjwZLTsyPzHyCyQ9RXbpiHJJOsrZ3oQv3uPas1VIJ0ZqwQatoNAPvlwz0bKAIqloB0JigXqH37KGVCtJ4=
X-Received: by 2002:a05:6402:42d0:b0:5ce:ddd4:7c2f with SMTP id
 4fb4d7f45d1cf-5cf05969b85mr823129a12.7.1730982371959; Thu, 07 Nov 2024
 04:26:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105100647.117346-1-chia-yu.chang@nokia-bell-labs.com> <20241105100647.117346-8-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20241105100647.117346-8-chia-yu.chang@nokia-bell-labs.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 7 Nov 2024 13:26:00 +0100
Message-ID: <CANn89iJV63py_q-wFGHHV1CsmjPFFdGc1z2BtnxG4=2fk8yMyQ@mail.gmail.com>
Subject: Re: [PATCH v5 net-next 07/13] tcp: helpers for ECN mode handling
To: chia-yu.chang@nokia-bell-labs.com
Cc: netdev@vger.kernel.org, dsahern@gmail.com, davem@davemloft.net, 
	dsahern@kernel.org, pabeni@redhat.com, joel.granados@kernel.org, 
	kuba@kernel.org, andrew+netdev@lunn.ch, horms@kernel.org, pablo@netfilter.org, 
	kadlec@netfilter.org, netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	ij@kernel.org, ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com, 
	g.white@cablelabs.com, ingemar.s.johansson@ericsson.com, 
	mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at, 
	Jason_Livingood@comcast.com, vidhi_goel@apple.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2024 at 11:07=E2=80=AFAM <chia-yu.chang@nokia-bell-labs.com>=
 wrote:
>
> From: Ilpo J=C3=A4rvinen <ij@kernel.org>
>
> Create helpers for TCP ECN modes. No functional changes.
>
> Signed-off-by: Ilpo J=C3=A4rvinen <ij@kernel.org>
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

