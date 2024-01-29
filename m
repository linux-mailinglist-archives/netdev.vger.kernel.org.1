Return-Path: <netdev+bounces-66696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 538E4840516
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 13:37:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6F701F21F26
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 12:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBAF160EC5;
	Mon, 29 Jan 2024 12:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SQASCoUf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45BB560DE6
	for <netdev@vger.kernel.org>; Mon, 29 Jan 2024 12:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706531827; cv=none; b=NSNH1OiUgZSkvb/E+8sJLYp3N+8NYSATPbNDpfh+qchOdfRpTF9igLfCBJ86FHxs3TaG4+3GmX0rV6eERTu70R5k0555ueN9ZJt5caXCbjwT6Mwkd5EGHljcbhRTsE4EY90AUfBNLsK48bHc52Jw77MSWaiJ+wgaKmiqX6O3TPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706531827; c=relaxed/simple;
	bh=svAOlluFAEpLJPpw9FnVbsi+CXhuZrXwZt0T28PPxZg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G7W2UeZAnWP/o095Wjz1g+CbQheP0cL67Bi+9kNUoehi2WcKtFqipuugZrtpZ0ekeKf3gVHfZWgYtAhlDtxVUGLRuqkegSKVj+QWtqIr9ZLHVhkthpHowpgjiS2FQ4I54oK6ElYzG1j+Hhdse4xkwIWYACgKuMfL67uGedqVLJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SQASCoUf; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-55f06dc2b47so4481a12.1
        for <netdev@vger.kernel.org>; Mon, 29 Jan 2024 04:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706531824; x=1707136624; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=svAOlluFAEpLJPpw9FnVbsi+CXhuZrXwZt0T28PPxZg=;
        b=SQASCoUf9GofJRhnp75xx9rLbs6au+zU1kiJ3p4Z8pBQS6u/Fe0NuyIHOYc5ZaX4ZD
         5+e6Eqg3piOH95AfvPTt0Lw3XLgqyHFSx3xOOFYW4uLlxXg0qW3ScYL3hI9aPzryghtd
         yX51arpMps08MHgG1FlfOMhRE/8kJobD/DOStkJifFPOuqlcUAilVELPgeWScWqIeUF9
         QUb7tn6RLjN9z/zFwZRIBEwfH46T0SPOPZt77as1cUVln0/Gzcgiz5NnZtTxDL36hhLU
         bbAN7qWtsltWqNVrRpHHbL8DSyu2atm+n+ybb6XtmuM2F60fkJ5yv04G+NdOntEKK02M
         m3zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706531824; x=1707136624;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=svAOlluFAEpLJPpw9FnVbsi+CXhuZrXwZt0T28PPxZg=;
        b=rO0ciKC+gQ/9zQc6fUTfvMn1vJm60pexGV4O+AjqKJCbcKhJwhrtI3J9qa6BhIBq7N
         BSEyAtJ9z7LHkX3WgahvRJQtGIP60j8yGQhRxvjuR6N25vJWmIjGI516yP6s4576zTDU
         I+L5IvivE+Ln7gNYweS5u+D+XO322R+BUYtf6OSDJR3s0ADtFD2e8o/fmjbJ3ABkrQQk
         GmuJXwYNbikK/PkAmd6viJiZUgjDuiOkPgKJ1GU0OEPZSyPd7ceAEFS4PSX3/iW56/0J
         vPn0w7d9R0UfciG1lyib1bWZYcdy0h/EDMpaK2CX2xloWa9ySvNhUUVtW+HtuHOL104V
         9MaQ==
X-Gm-Message-State: AOJu0Yze0bQrjhaesWWUK/QUHh7Kfd9eDRF78s3shJwwTiY2yaBVKi8e
	zb9LjBKePnRZvJ9L5gcczPpsKQMdvp/ueiULIEP0APQJ/ZvXWjcAG5JWqcB5q3Rup/3xRYm7AtY
	fdB5HP5vXx/+1RjgNCRFLxiojzFR2xiFQB14GUk2iQ5KxORK5/A==
X-Google-Smtp-Source: AGHT+IGv2cixMO/xmqEAGqfDdKYYL/e/273QHm1vHPZFapfBguO6yUPBkqiwUoJjEjyN2tK36T1v5/x/1ctUJrFASOw=
X-Received: by 2002:a05:6402:2065:b0:55f:2888:3941 with SMTP id
 bd5-20020a056402206500b0055f28883941mr13995edb.3.1706531824048; Mon, 29 Jan
 2024 04:37:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126201449.2904078-1-kuba@kernel.org>
In-Reply-To: <20240126201449.2904078-1-kuba@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 29 Jan 2024 13:36:53 +0100
Message-ID: <CANn89iJ1RR6Hkezdg_xDZjvDcMcZHeo-aw3v8Z6erzrhwM8-tg@mail.gmail.com>
Subject: Re: [PATCH net-next] net: free altname using an RCU callback
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com, 
	daniel@iogearbox.net, jiri@resnulli.us, lucien.xin@gmail.com, 
	johannes.berg@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2024 at 9:14=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> We had to add another synchronize_rcu() in recent fix.
> Bite the bullet and add an rcu_head to netdev_name_node,
> free from RCU.
>
> Note that name_node does not hold any reference on dev
> to which it points, but there must be a synchronize_rcu()
> on device removal path, so we should be fine.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>

