Return-Path: <netdev+bounces-96792-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C142F8C7D8A
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 21:59:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 655DCB21A3E
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 19:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A230715746A;
	Thu, 16 May 2024 19:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aTz8MYYW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B95014B95D
	for <netdev@vger.kernel.org>; Thu, 16 May 2024 19:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715889567; cv=none; b=luEqSlYDPEdnK4yvs1TOfkeJQkVYE+c2VRR2SCfC9crJSdF4SGkeWHNTSnggKqiuuuxhjW5BcOl3OsbVknk5qoX8pEn2yLesNSHrHGKQNEIEzDO40gqI3kBQtrW7WV2Y0O1SbqqbG7lytklAyzpgCjV5TvJFF2RwiuIXhrbhPYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715889567; c=relaxed/simple;
	bh=mOvYAjzd3Xb/tKCwrrQVTVeFMalRcpZobe/y6ZpOHx8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ivCYfVziTbdMRQ0YXvx8SImVXuxSxFRVK9TkKuRBQk3KPMytgMxUggljXOZ7FDYhSz/9jmywsF4JzLtm/XUoFG28pdAqXo/Jq4gqJYluCf2khNnS82IrJjEv+Ql3JW4PLWx9vsN/2cSwmZN8b9Mq+O1rnxqVUnRmc6shw3xVbwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aTz8MYYW; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-43e4020db92so6035321cf.0
        for <netdev@vger.kernel.org>; Thu, 16 May 2024 12:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715889565; x=1716494365; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mOvYAjzd3Xb/tKCwrrQVTVeFMalRcpZobe/y6ZpOHx8=;
        b=aTz8MYYWqsOC5PBy637qq+VhZTU2cpZFsNbiDa50M95zqm/4fkUOhIZWmbaGbi7uTs
         ho9WWVN9kjOoPPek/sPm/Y3QYRUkNhx92G7vrxt+cQ2XeV7AbJDje2W2qw63cN4C6qHe
         PNnNR08lERUEdAAdqFLH8M5NkT6MRAlX96X/aQYQd/8yk6a3EHPgMN376JrcXFyy2P+C
         HyJkubE9Z9AMI0PPvhVWSbq7ceXQDo0hQX3rTF0cdAm6yCBTpQ3APXbrk5B/OlzXBUh5
         C67pqu+rPOTCN7zVcd+9BzaVRCk4EH1+QTwPOPZdNNR80uzxbKAOgcQn2tFFEVgFa9Ot
         d5bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715889565; x=1716494365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mOvYAjzd3Xb/tKCwrrQVTVeFMalRcpZobe/y6ZpOHx8=;
        b=rq+2w4EBFBwLP439+bjoxjE8ZuBhmCkbq1HwgSoeHmeSYCZUHjSmMRBfFV+Hp0fDT8
         qOvGszZDmLZXb19C5laK6MwhJ+BO2dyqb1fdf7hJueagxCtshJlxZE1kKX88zzy6ugBS
         HKxJKHlFqkcctvVHPR373rK40dU2GsPbYWYbBZ24dDPeXQf80WOgiDc+agIxg/AWnnZQ
         C2UUrwuQsNLQxKX/25mxhL4nt0SvXl+NhO1E0WlLrOMvE2po11E9yly5/2ucZiV0V4jy
         GWo0rKKp3n69tAUv3G5v7rlOvVT1YEPP6PCtYlp9oZAQtsU/bA2Au3FOSV7SmKims9cC
         l/HQ==
X-Gm-Message-State: AOJu0YyUtZa0hhowFLnul7w4lqfXE7gOE7T1p7R7mG36l6g0STPSYKq2
	YfjgN8J1lamxD2nTI7J7YrclS3UjDeAALmO7nRI3bpsS6b10VVjmgNDRZQgIe0rA8GNvFxNqcTB
	3WA185nhUxLlr6OVJfZodBQLXvjY=
X-Google-Smtp-Source: AGHT+IFKP3k8qLENCqT/FrsYZPMvrj65Wfwrl3+zlOymXPvGRfwn6O0D2/e1rsmNkfPmzYOne5wW22iNyYSKfmsrvqU=
X-Received: by 2002:ac8:5a49:0:b0:43b:b5e:cb3f with SMTP id
 d75a77b69052e-43dfdb482abmr248616271cf.47.1715889565029; Thu, 16 May 2024
 12:59:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240510030435.120935-1-kuba@kernel.org> <20240510030435.120935-6-kuba@kernel.org>
In-Reply-To: <20240510030435.120935-6-kuba@kernel.org>
From: Lance Richardson <lance604@gmail.com>
Date: Thu, 16 May 2024 15:59:14 -0400
Message-ID: <CADuNpCxb3NV84BLQd7064q5YEjnYutDqerY6dvTRDsqdK2fO3Q@mail.gmail.com>
Subject: Re: [RFC net-next 05/15] psp: add op for rotation of secret state
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, willemdebruijn.kernel@gmail.com, 
	borisp@nvidia.com, gal@nvidia.com, cratiu@nvidia.com, rrameshbabu@nvidia.com, 
	steffen.klassert@secunet.com, tariqt@nvidia.com, 
	Lance Richardson <rlance@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 9, 2024 at 11:05=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> Rotating the secret state is a key part of the PSP protocol design.
> Some external daemon needs to do it once a day, or so.
> Add a netlink op to perform this operation.
> Add a notification group for informing users that key has been
> rotated and they should rekey (next rotation will cut them off).
>
Does this allow for the possibility of NIC firmware or the driver initiatin=
g
a rotation? E.g. during key generation if the SPI space has been
exhausted a rotation will be required in order to generate a new
derived key.

