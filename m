Return-Path: <netdev+bounces-98680-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1078F8D20EB
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 17:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE92B28941E
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 15:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B9017166F;
	Tue, 28 May 2024 15:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k8gj9Gou"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632B717083D
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 15:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716911864; cv=none; b=c3t6lDxbodG8WOqSFIrzlFgyn+QwaDub8KFIp3YSvSiknUjK0Om0d3pXLG7QGEmvVPvhDXks1M1Q1gLKjj1OGggfUJHsuOtFvtqGiOIZDBF2JJl5cBhD/eczUwWpz/BA4pucfasNZBW1EGC4CM0IbK424y4zvhVC8nwvltmhyeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716911864; c=relaxed/simple;
	bh=L4Q0daVpNgiK2EBXZlhxRfnJ34x5ZUjcvNPokATBUmY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BJn+THOl0drzWnrKziEtyCBvVcCqtdp74omaARHWWyCCWmrkYZIdhJ22SRMViWjPnDLDWZWhu2gf1ZInwd6sGLRlRID3P0QVLu1pfCCyj0E04qUDQBot9VMRsD7l+a5X/BY91PyqYujPhtGg/1m2YgDLNqMp1YXjLzDbpLmmBGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k8gj9Gou; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-804e6d4206dso273762241.2
        for <netdev@vger.kernel.org>; Tue, 28 May 2024 08:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716911862; x=1717516662; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L4Q0daVpNgiK2EBXZlhxRfnJ34x5ZUjcvNPokATBUmY=;
        b=k8gj9GouBbjlTgKzpBA2H22e5HGW+XaZBLuCZLCpg77+GpPs6m8JqyTrGO0h5W3FXD
         dBVDEOR5gTk18tixtyz3wihUGFwgWVVzhZqNj1PjNyi4reEC7CasD1YXQe/Py8JJEqJA
         KE7mOgcwyRJUtoe0VYkzoNEYm3paFATOZtXHYZ7nOUm4V9sZsjUx2EqI9usHd9WpzhUA
         F8+rHQQvIrwY6ttGiOeji49OpdBlwRxGy6yhyHzF8XoWmIUgZvx1ok/fFQC+IxplKXNN
         4+MwoWlLRbQwDSUMO1Fye62i2gLxlDeMUkdCFa+houYIdBTZSyvKbVpozKg5hRVzoB4V
         jSeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716911862; x=1717516662;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L4Q0daVpNgiK2EBXZlhxRfnJ34x5ZUjcvNPokATBUmY=;
        b=Lfqc0QVdRA9nZC6atfJFISH+4gAGJGdNE9X//FnXlK5KJVnxt8wp7o6q0UAqzhAPAO
         gAIcCjM5Y1enzNo9qRuazlPnVGqdN0Vzh6ereen4n+6V/k3X7MogUswxLbrT8XzT3LFo
         3TjzGUwZOKz7XHaD73jX7tVEyPF06/O2qRJUCghIoG/uHLTLQgJBqHZ5rX868AVFaiM7
         pqWjAuhQVnYDw4tMY7r0qxX/A2B/bSNimFWUmkWQhiFtuhxPpc9psCICQ/eiIHY+4m+d
         4KOGuaJDMV9Alani/fPutI9zoyBpSGi2JvrV1x4wVRu+x0CSTXrp327+e7cBvBrwU3d0
         LFiw==
X-Forwarded-Encrypted: i=1; AJvYcCUIE7I+4gHRf+0COghEoibJRwc7kFxl4Zce+tBL5kbHC/Lp9hNYFfnPfiWXUc9L0t6gXCTrFavcLMyXsHPxlZJjNwGE0s9k
X-Gm-Message-State: AOJu0YxShgcGJMW87ZbEdFIiKzMOCrA0L8GZIgajI/KBvTFgk4I91qRE
	LrYj27Mt0akfXC2o1aAs+qlIs8psjQZ6363jGVvDDWN1Rn0hOOS7H7O7hMtCyMql7NC0kiBJEKj
	MFA2O4ujvV7GRYEYXMJ6gDJGNsnONWh0jeVlK
X-Google-Smtp-Source: AGHT+IHlInOlF0aFOB6VN0QoqPGfCiJp02WvU6H92bD55Wdu41YMWE9Qk9rwlc0fiGBJOEN2PAgnQWL3YKzu4S0EGvs=
X-Received: by 2002:a05:6102:190b:b0:47c:2cc5:fbad with SMTP id
 ada2fe7eead31-48a38600240mr11437188137.20.1716911861961; Tue, 28 May 2024
 08:57:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528125253.1966136-1-edumazet@google.com> <20240528125253.1966136-2-edumazet@google.com>
In-Reply-To: <20240528125253.1966136-2-edumazet@google.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Tue, 28 May 2024 11:57:22 -0400
Message-ID: <CADVnQykoAGACQ=KP=spqAk9uYenLj7jqp+AaB+6xy5biAaoj_w@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 1/4] tcp: add tcp_done_with_error() helper
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, David Laight <David.Laight@aculab.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2024 at 8:53=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> tcp_reset() ends with a sequence that is carefuly ordered.
>
> We need to fix [e]poll bugs in the following patches,
> it makes sense to use a common helper.
>
> Suggested-by: Neal Cardwell <ncardwell@google.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---

Acked-by: Neal Cardwell <ncardwell@google.com>

Thanks, Eric!

neal

