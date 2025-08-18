Return-Path: <netdev+bounces-214503-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4B4B29EC4
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 12:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C7C54E2FD6
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 10:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 852CA22FDEC;
	Mon, 18 Aug 2025 10:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yybnHnvP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0020020766E
	for <netdev@vger.kernel.org>; Mon, 18 Aug 2025 10:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755511372; cv=none; b=nOfap/bnD1uNuahwfqWFmdA8mkspy7H2aj/Yd4WkcrnNrRCQ6pZhA1pZ16xpJHH/WJT333+xsIfGI+vp41lepdAzSpavPV9dICfJ7aZank4dYwTH3XCxxVw5RohXdnbusknm21mohWiLZ9/ua0zbo1ICbx2A6Wtey9U88csdZk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755511372; c=relaxed/simple;
	bh=3NqWZsfVgvje6yEl7akk6ywbTjG5rpVu7r1cqPrcoLg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y1S6m8RlRIQU7vKiJ0GJrS/nf7g/qQwMUIXOvnAQ4PE41780+IquuJgtcpnUw9ZKDwySqPBo1+d2j8brxcdME9GzwQiz60pr4+Ju/34mBPwqKvhuTeqnj6fQec4+sXu43DUOeU3mhdOm4bxvUOmwqiOrJaXR6M3PIsxxxRzgfIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yybnHnvP; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4b1258a3d71so23623481cf.2
        for <netdev@vger.kernel.org>; Mon, 18 Aug 2025 03:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755511370; x=1756116170; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3NqWZsfVgvje6yEl7akk6ywbTjG5rpVu7r1cqPrcoLg=;
        b=yybnHnvP0IXkkP9r1+rL2Z/WyiCRmhepBs/LGl3+RvO2iiR352dE3CSx44gGrQezjf
         MfBvoP+JJ3Hn5j28YLT+a8MwFyEp8OzynKkHqWrO1F0n5vwuieD47h0sDd/mL7xXvt0o
         4oORkpLMd528m8kMYCYktWkELixXv5vdWwle/80J6ZCL2/4oHJcLy5BuDFBXF82tRgwv
         m4To+KAPl2r9SiLD3SV+4nBoCtrlyw6Lz+ay7+vtkPtsqEr6Kr1Cfyye68UeyaO3iOH3
         P3KGW3MLrNEaJDaVq9BC9QYjc1iYtfKYr6rqYiaMLK/g2/14T1n1kKwCeCLfR++VeZ3i
         0ZAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755511370; x=1756116170;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3NqWZsfVgvje6yEl7akk6ywbTjG5rpVu7r1cqPrcoLg=;
        b=Y3fxBJJ+SVv2w0TsTnLq+gFt0AM9mXsNxsc8+9/zkvMGhxx8nOnLfMKbxVScjpk/PQ
         OwV6rNFw/2c0k4BaTPl/N8/WJlkoDBOFGZQyFZ/bv9NuxAmAeouNQaX9iRbVJiInkIy2
         O3OCqUdelXFwobfmfJdRSb1Kxi0I4qF04Y4acWIgH71j0nO08uCy9spjIGO15yNiaJPW
         tFDUaSUal4/rna9OBoweLNIHOpUpqM+87wtwjzEHbvusAOkvWAmgY0y8s/Jb/EN4fSDj
         oizUUgQStwHE9QvSLYt6NcI2KkvQQ5Y6OmLkEsZczd5M39oUi1KrQRK4hkCypOrSldmC
         +HBw==
X-Forwarded-Encrypted: i=1; AJvYcCVGZ80uS/66qr1qPxOPQHqiQd0xvCPiFAIlSHljUsX6CwFCwr0Yy+ER3+dfOS9i0Auxf4HIhEg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAPkLfwEzAbdwpmfjVPHxSdpWocve1pOwGRjIpL2l5OTpOTeHU
	fwmoB04Bs4uEPxgQMezdxz0QIkmw1xDojab6wUcQlFh7xmSPh71XWEPBIsaOGNcregI5+F5DGhM
	59QBnkZkJY7kDN2zW0/KpEnhff4idpfCTR8xn/MbD
X-Gm-Gg: ASbGnctKZXqx6oQNg9ldKovNSt1rfn/SZeaLnEtuwDlTQBmHIUZvJ6pj8blxUQUJpd8
	7kjdJz8jNp1oYYLgKJw9sHv7ih8JZ83DWbvlUpseuD9bbayw7nA2oXKCKVPCjtAprdvC9Es8rwx
	MSr7oxGbUJ8yZEaFNdAIbE8wm3wi+gMfNMGO7jgYUAZWida4ixJuPh3Ft8b+CCRV3J1cwGu0F1e
	aFDyEEGbHBeiUzcAkJa4eIWqw==
X-Google-Smtp-Source: AGHT+IEw1fHEdjH5zzJ7WX5ma7ll7+W39xYnKWSXGRi+ejw6pitipzUftc8GSjLbpQAw4+cKDk+ViZjASunsMtHaqts=
X-Received: by 2002:ac8:5711:0:b0:4b0:7c4f:aefa with SMTP id
 d75a77b69052e-4b12a74e444mr93533691cf.35.1755511369184; Mon, 18 Aug 2025
 03:02:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250816-nexthop_dump-v2-0-491da3462118@openai.com> <20250816-nexthop_dump-v2-2-491da3462118@openai.com>
In-Reply-To: <20250816-nexthop_dump-v2-2-491da3462118@openai.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 18 Aug 2025 03:02:38 -0700
X-Gm-Features: Ac12FXw1GGU23jOtrCq6tBXnI4NsS27uMpP5eNfkFDnCKUss_z1Gfr2rIjR2lwU
Message-ID: <CANn89iJeOp4_+YknUxnBheWo7WqGzvoB6trp9RV8Dz9-AogppQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 2/2] net: When removing nexthops, don't call
 synchronize_net if it is not necessary
To: cpaasch@openai.com
Cc: David Ahern <dsahern@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@idosch.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 16, 2025 at 4:13=E2=80=AFPM Christoph Paasch via B4 Relay
<devnull+cpaasch.openai.com@kernel.org> wrote:
>
> From: Christoph Paasch <cpaasch@openai.com>
>
> When removing a nexthop, commit
> 90f33bffa382 ("nexthops: don't modify published nexthop groups") added a
> call to synchronize_rcu() (later changed to _net()) to make sure
> everyone sees the new nexthop-group before the rtnl-lock is released.
>
> When one wants to delete a large number of groups and nexthops, it is
> fastest to first flush the groups (ip nexthop flush groups) and then
> flush the nexthops themselves (ip -6 nexthop flush). As that way the
> groups don't need to be rebalanced.
>
> However, `ip -6 nexthop flush` will still take a long time if there is
> a very large number of nexthops because of the call to
> synchronize_net(). Now, if there are no more groups, there is no point
> in calling synchronize_net(). So, let's skip that entirely by checking
> if nh->grp_list is empty.
>

Reviewed-by: Eric Dumazet <edumazet@google.com>

