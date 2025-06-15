Return-Path: <netdev+bounces-197853-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94093ADA060
	for <lists+netdev@lfdr.de>; Sun, 15 Jun 2025 02:18:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4225C16D2B1
	for <lists+netdev@lfdr.de>; Sun, 15 Jun 2025 00:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C01136E;
	Sun, 15 Jun 2025 00:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aoyDbZbF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F44A41
	for <netdev@vger.kernel.org>; Sun, 15 Jun 2025 00:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749946703; cv=none; b=XabiDJm8uuNWZbFA6oXXHHF9mjbmCEm8N8uUWOnWuvAYm3U1UsNkqPsVygdcaOc0KN4Qs2U2HTgyN7pQqR9rdUny60emSD7OmNBZ6AtYmbqa6sWAppvO3A/ck+r3ieLItwxQVOLodFnKXK+WAG0hs/NQQoIfulpjvRw4sYY0XOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749946703; c=relaxed/simple;
	bh=ZMQesgi6f2OLHtlmK7CeV9Ylxnenb7ncWMzJR8LHNm8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kw8jAgs7pJFBndH3n5YjQyuFe2MIYemKTnDW7lVwI27lJ0bC7G/2MJtKbNXT2nBpBaXj2CJXlMxVcTiAOKQ5cGb6jSAIH50UUClQO4cIGwKU8qaej1hAvz4lDr/lXkzde2Z1X4zER+HCaPbaaefHcRmJnrlhI8q+m5X9A3uo1G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aoyDbZbF; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4a5ac8fae12so295451cf.0
        for <netdev@vger.kernel.org>; Sat, 14 Jun 2025 17:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749946701; x=1750551501; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lptlc32Ij3iY4cD0C1287y9up/7b47XVXDrN+/2CMwU=;
        b=aoyDbZbFm1h+xbf9NV/h9jREzqWV1Ki+w5LT4kwTjGKnGsa9JQsTfhvjYWxTsHRz1i
         +zq4krJIYYMMwD9P4B5mXfmWeshmo6Bqsf2rbGjNbqhu/UOvPMaSEsZkmR0HHrRf+U2c
         kbfF614ZUxZ7xMCAbGNtSX3JqKbFMDbB2UW5+Ia5YRqcNv6j2lrPbwWluZGvCDh2O097
         6cTI1hfN8izjxT19Qcf2sEDSJuZT1Jo/09IrAMOXfbohUh9qG7kB8N7RNzIv/qHv+dY7
         vD3xPhSUiOTm6AmQpTJuzuKtLqB2vng75aRZ1ZxfUKyD8vH+2NjD5aVObo/oNRePq7Ix
         ue9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749946701; x=1750551501;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lptlc32Ij3iY4cD0C1287y9up/7b47XVXDrN+/2CMwU=;
        b=keFGQB+SpYu+y2Kl5GzI+Rs2wcLe4dk1uh0l72w4ZIFWTku7w5kaDbMxr/jjD/2Dk3
         lcRByhk6Oq0G9ZGVPOgjRQhjbYgEjK88optwpv+xrRZSPW0iB7Jg23vF6KFmCAQv1COS
         H6z3FJBh+ROUi878sLlAY7aa4PivNJM3PUs7r3muwpozvdT8rXBNzsveRuxgnsI7j5q4
         ypEUjPhBVBEPCWiCD7z6VUrRzbjw3p4QcdM5OJ3QuFKsGfuly+J6yAGAAZBxPpZwpO9A
         T14wqmNwKqVP0XOuKXB1TXRQkrjeKdPHkUNBly6AWFgIx/iOkqqZdDW95nydjmfkEPFe
         mR2A==
X-Forwarded-Encrypted: i=1; AJvYcCUJQZ6Mj7HkzeloibVTs31FjMelniLzpCRrIx/HBONEFrSqAwT4kHvuzeIBhG3MCzQRCh+UJJI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeJEViE70qAT8ICfs8t2r+m3puQ/iKG7/NywulIRDT8Rg4sbpq
	6+90+rBsF2smgvjhNqsZIHpeerkU1HsoSeqlaEY7CT//GyDBsbsLXSguHJ2THEZWwN9plITvEEi
	3BRwNrAcLMivZgBFEqc9luujp6wo7XAG5FylLTx7l
X-Gm-Gg: ASbGncsWq3pMuXgPzCzP7dp7lu6iES+/T1e9tzfsgLjZsIYbRuf5dy/77YxUsigmeaV
	wBnZAfp4CrapPYZirewYKcEHKTSLBa4RrfVJGwigjsl96GOYDGBMLMPLrsl1h+GrW3hHrEdjgy8
	Z2oBIAFVwch1onCadhR6/6o9O6/35apvFzXiKRlYbH36YPSgVRIDecnZaHZ2yvviNfmBlFb6xTv
	a5B
X-Google-Smtp-Source: AGHT+IH6e9iO7kIJQV34HrV+XLR0q6gp3eRU9I6z0V1TZIUq2FiIqpg8xD39CuhfOjWYzPzK7djAaVMthbA/oAmZKjU=
X-Received: by 2002:a05:622a:1882:b0:48d:8f6e:ece7 with SMTP id
 d75a77b69052e-4a73f2bb074mr2018981cf.3.1749946700248; Sat, 14 Jun 2025
 17:18:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250613230907.1702265-1-ncardwell.sw@gmail.com>
 <20250613230907.1702265-2-ncardwell.sw@gmail.com> <20250614130717.40a42cce@kernel.org>
In-Reply-To: <20250614130717.40a42cce@kernel.org>
From: Neal Cardwell <ncardwell@google.com>
Date: Sat, 14 Jun 2025 20:18:04 -0400
X-Gm-Features: AX0GCFvsl39Jhm_I3q9QKCHXbF6pUB-YUTINPH518eE6n1fH362bIgGERfX5CaY
Message-ID: <CADVnQym21-q9SJbCNZR0qyLJHxCFLYUjSUr4wMyBdVA0TMgjEQ@mail.gmail.com>
Subject: Re: [PATCH net-next 1/3] tcp: remove obsolete and unused
 RFC3517/RFC6675 loss recovery code
To: Jakub Kicinski <kuba@kernel.org>
Cc: Neal Cardwell <ncardwell.sw@gmail.com>, David Miller <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org, 
	Yuchung Cheng <ycheng@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 14, 2025 at 4:07=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Fri, 13 Jun 2025 19:09:04 -0400 Neal Cardwell wrote:
> > RACK-TLP loss detection has been enabled as the default loss detection
> > algorithm for Linux TCP since 2018, in:
> >
> >  commit b38a51fec1c1 ("tcp: disable RFC6675 loss detection")
>
> Hi! There is a warning here:
>
> net/ipv4/tcp_input.c:2959:6: warning: variable 'fast_rexmit' set but not =
used [-Wunused-but-set-variable]
>  2959 |         int fast_rexmit =3D 0, flag =3D *ack_flag;
>       |             ^
>
> and another one in patch 2:
>
> net/ipv4/tcp_input.c:3367:29: warning: variable =E2=80=98delta=E2=80=99 s=
et but not used [-Wunused-but-set-variable]
>  3367 |                         int delta;
>       |                             ^~~~~

Sorry about that! Sent a v2:

https://lore.kernel.org/netdev/20250615001435.2390793-1-ncardwell.sw@gmail.=
com/T/#t

thanks,
neal

