Return-Path: <netdev+bounces-190806-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4027AB8E7B
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 20:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97AE31BC5BC1
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 18:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 615B1259C83;
	Thu, 15 May 2025 18:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d9cw5IyI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB90259C94
	for <netdev@vger.kernel.org>; Thu, 15 May 2025 18:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747332439; cv=none; b=H9fuBv1cPpKBNOcYAsbgrMdmJW0XUjzYDQ3hU3rKJaLAheFxuuIeoalOtHeHTrbicDFn+ilJdHftERgtS0EB51cR6iiCzY/rWct5pylJLLK0bT+6kigtIQomxKQMV5o7ENS9dSePY5ahTZsDvQYw334gD1jLa6tvitmdoAzjrTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747332439; c=relaxed/simple;
	bh=j50PyLthzigmRDeBrack/Y3Ta1RreAcoyUiRTwYZsg8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=l7VQG0Pe8jSN8z3FXHBcAWkpPoUsC+lO8fCyZTb1j7HcszJyWiNE6aMyGb590B1X7L2BOZqXh1pOryTxnI3uC+VHI/NnBSNVwtircN4WjqBnAZdmnLb0LUuI2Q+9madSQtd0uezz4sMTecX4LJ4sanyKaTkd+06CMqnLC/T3Bfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d9cw5IyI; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6f549550d96so16014486d6.3
        for <netdev@vger.kernel.org>; Thu, 15 May 2025 11:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747332436; x=1747937236; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=maXQia/pDVUZJKuCY3qGZ0eNf+LARcg8qYKeUEByuMw=;
        b=d9cw5IyIJlXF1wjytAFB2T6eXk2czyX0vCsoaFXRx+hj4v/bpyl37rjW9N4bWKTCdL
         9gf++VFlB6ljra5FAGEXcqv+TxYymijQzaUTJqPG8P2r+kgNLd3A2fnWMjJgE3IRfGzW
         RD8bkRPmhtlrp13oEvcaM+fN3IkwpVDvFyqcIhIpdCaHmyhctT7v7PUQDmuP80Pm8FfI
         k/XzaSD2FnGsP5M2lC8+DeXzk0LWEKSstTjJk7WA4oCYfQ6ipptloI5wzkKCMphvI+eN
         fqqDFpVA5GUui1x/NyARDUdinktGiVIR5BvfLUWYhIUYLkDi8oWoP3zFyOZ3T45SgsxB
         heHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747332436; x=1747937236;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=maXQia/pDVUZJKuCY3qGZ0eNf+LARcg8qYKeUEByuMw=;
        b=aIJ4ev9Jr/eNPB+eBPlf4b8BYqlIAUJsbrfeOOtUJI24VanHDV8V2SPViPYNA9oVGo
         W/OEXusGi+CPjbBEumVfrFM1wrscQ24GBDHM22x4/WrUXvddcU6qN4mHtUjb9gS9Qqgp
         CnwP6+I0EeR2ywG7h9hVSBAVO1mTEoGWNtA64moIUgHpL4mu6QmnYJ+w6rkkw/ep81Jd
         ZA8Veng2PFsVzeACirTFTUTS1tgC/kgsJ97Fr0K95oqcYyStgPY1W3LTsJRSmraPPMG1
         80WToAVkrI0jjazUozcWHzElR/ttwrDccZrLBFqcoxsMWaEXsUhSh4AcBiO3uby+Cjjm
         Ecsg==
X-Forwarded-Encrypted: i=1; AJvYcCXW/ow5mL2OEQfv3J/go5yJbWMCS/n8xPJXAJgCR7udLp/q0g8ngrtXguW7q14bDj11tsodp6I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzehtcIA248A2T436MFTQ422hH/+UUUiKgxBqBN1pDBLTt51+yk
	CA4KaphwZzGfCCCc9Fsv++2Tb0uD4OpQ6UTmumTdrPzR+lO3qGWzxzRG
X-Gm-Gg: ASbGnctvh8dm5XCQnBTyohJDxURdL1sGsE8ZvLQqftDxukHg5yqtLPBYiuZiNEewr1V
	Z4NV2zYo6luwy9HjXMYKUGejwLTirPGs+AEc54GCaqTxRKLqnNoJi+i7OE1FmnKCZvNn+d3vQmF
	cvknrZ9zeOe0nws819NkqVKvwRkpZTMga1rBJ2W0j5QjC04ELXHHsdlQB49wnpTdV20g5HJlBl+
	wkKKgi7uqopR5ZJ0D/4dcmOBzxGLOZl4HGCJ8TCDbOcu9ngNAq0Ag/2+awIV87PoGGJWeE3eyXu
	YB6heH38Rx16XYwscUhdalSzBkQTJH0oGJIYVdS/fjY1rLuOQXWfYAlDy1i1pzQAmrE68dHZQBN
	PdMKrhVSKoI2blb3UUvSmXMUfQ89AuxQXMA==
X-Google-Smtp-Source: AGHT+IFLiyV24ThQ4tK8D3q9P2MBiRc3fZigV1zja32DSLHsmR2Z9vQOuxvD0DqTgCXi4b5wABsxEA==
X-Received: by 2002:ad4:5cca:0:b0:6e8:fbb7:6764 with SMTP id 6a1803df08f44-6f8b08f97c8mr12075866d6.45.1747332436450;
        Thu, 15 May 2025 11:07:16 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6f8b08c0c2dsm2269906d6.67.2025.05.15.11.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 11:07:15 -0700 (PDT)
Date: Thu, 15 May 2025 14:07:15 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemb@google.com>
Cc: Simon Horman <horms@kernel.org>, 
 Christian Brauner <brauner@kernel.org>, 
 Kuniyuki Iwashima <kuniyu@amazon.com>, 
 Kuniyuki Iwashima <kuni1840@gmail.com>, 
 netdev@vger.kernel.org
Message-ID: <68262d53282a_25ebe529443@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250514165226.40410-3-kuniyu@amazon.com>
References: <20250514165226.40410-1-kuniyu@amazon.com>
 <20250514165226.40410-3-kuniyu@amazon.com>
Subject: Re: [PATCH v3 net-next 2/9] af_unix: Don't pass struct socket to
 maybe_add_creds().
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Kuniyuki Iwashima wrote:
> We will move SOCK_PASS{CRED,PIDFD,SEC} from struct socket.flags
> to struct sock for better handling with SOCK_PASSRIGHTS.
> 
> Then, we don't need to access struct socket in maybe_add_creds().
> 
> Let's pass struct sock to maybe_add_creds() and its caller
> queue_oob().
> 
> While at it, we append the unix_ prefix and fix double spaces
> around the pid assignment.
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

