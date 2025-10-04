Return-Path: <netdev+bounces-227860-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4933EBB8EDD
	for <lists+netdev@lfdr.de>; Sat, 04 Oct 2025 16:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02F483C407B
	for <lists+netdev@lfdr.de>; Sat,  4 Oct 2025 14:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BEEA20296E;
	Sat,  4 Oct 2025 14:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="bWGvfwOF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC3D145B3F
	for <netdev@vger.kernel.org>; Sat,  4 Oct 2025 14:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759588310; cv=none; b=Os8OsVz0WWWj6+Ac7lnM1+XbfVoTiPkh7eCWO8aW7yAGXSvMUj9Uux+VWgW23kLSNzX1fycy+FADVnNHYud4TZ2upmp3VexImov/0HqkA5ih/zbNTjC2xr1Tx0wsvK647PdnFGqwXSmH+CqE314d1zkSgGkvUayueaCSHpxNbSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759588310; c=relaxed/simple;
	bh=xIpon02+PxxhgZvHq/oo2SFJKUD6pPkmd3iQGroNCAw=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=BCFnQ0t2L2jsO2zKpCcIAT/ktHs2SJUqEprHNTUXC/R3X1+ZOW+tkuSS+QrJKYGKRZnglOt+NdMJiAYMnI14kDyJ3SukGNurgPxaUggQiZKA9AmR3hkQmhEcx23PztMI0q45/fbc6xkFWAoMTKEi0K9eXFGLvQyqIjkZLnfXusM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=bWGvfwOF; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-62ecd3c21d3so5961821a12.0
        for <netdev@vger.kernel.org>; Sat, 04 Oct 2025 07:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1759588308; x=1760193108; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xIpon02+PxxhgZvHq/oo2SFJKUD6pPkmd3iQGroNCAw=;
        b=bWGvfwOFKIORxyYeTPYWCXk3b98by/+Xawrq9GT1tYq9ygtjyEq4s4+y1KXf80a/hS
         18mcpVntqENjdTMNQ6lekAJWVxSvCeATQvJsD7po+rQEDB8XZoQHtg+wv2YZXqBasA9S
         P0y/GMZelD3VRm0N74lA0jXaD0/SRjgr7+8EfFBYgsgsg6S778KgYAou0qUozEfe4C2k
         9LDQyPI21Qa9rW5ru3HVwZlKJmB3GNk9QuDcrdTG12O96i5d858DiuJW9ZRVhkIkmRrH
         dTEgGz1mxC+gmAMeHbyfP37AwjTb7cB99e/0NpSCA7IeuiwQEs7cKvGQGGPlw96g83jT
         DDpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759588308; x=1760193108;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xIpon02+PxxhgZvHq/oo2SFJKUD6pPkmd3iQGroNCAw=;
        b=LmJh3M0XQzHA+JAeGNiUMNA/S5kPJRAm/KIbYC1vyIPmxKAVjBEk9YX0HV3Sp8eGKA
         bCsCMz4vo4Bp8NNhv8Gz0MSTEYwJp7xfcTSoLeM4OoZsNoi/W972SP90TZvJssVl5H4a
         FGIz0ABkmzJuRWI7R7LXUNetm5+pe40f16rFPXHKnSW5D74v0++LCfxRhdnyAJm6fUYl
         dxBfO/vP29dClJLOwqBS5iAO3xVBwOx7G17VOwHZ+GmZVao7B3UYrx871fHAGH40I2Le
         BFh5O9VCnPI3kUtKAlBHhdOFhG+DIerUG9lvQgOLuoBbMmJwnxny5J0bkw1yTkjXApFp
         BS6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUW5frxQCS8qceNzBJHCdyuVOp8G+WhfUC5c8MAVHK3oXIo248RgE6VH+QEqmymGbYE+6iKgwc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV0jUSGrKcTU4KThb27xHP8mdL88m/6dBmyYCu45lh1iXwdEQo
	rt9xGd82f7twOvQ5LmTptQEf4QxaCFGm81QYrJl8P9H0Wh+FAZQp0pQqnmZ5TW/5EXg=
X-Gm-Gg: ASbGncvR+4J+HyRTKx9KIyGlwzOKk/UcpCLWf2mP4mLMzDX+4DnQ6RKno9kJuUvIZJ/
	sVdRHoOcKJOgRf2fpqEd2iaJ+5SjOchdo5hMZyQWOLmd0i+7ThEciMqLpPXej3s9zgmgCm+zlss
	97Ec1rO1sMu8FsRRCbvH5Hh9vUvplh79ktjQnrxiAwA6+vF58x1g7xcz0h0TvAfZi0dRZ6nOaE3
	09pbW1X99WW8WZZ35tVNpFa85ubFDeaDYEdaYmLkribAMJC+V2bgAPm/85nOdQ5fwvp6PyV+TXF
	FykzBdgk4j8mGDNmqtYsHOcSU+gAdSc1ieOKx7wdHjtT79tlQVV1BUHD/1YFPq9nmVltU+qT7Tq
	lQBtFP5uLuE29LTQyEHPE8vYaXGpPuJlWAUVzBECZ7Rr0Zxe53dcuh6kQ1sYlH62XEw==
X-Google-Smtp-Source: AGHT+IHiaKgJ510GpGFJf/bD85KK6EwJE5YnqKxoe4rZdpetGANffy6OLHDG1PHEb/0alwwlC6EX3w==
X-Received: by 2002:a17:906:f599:b0:b45:a03f:d172 with SMTP id a640c23a62f3a-b49c407397bmr880852366b.57.1759588307449;
        Sat, 04 Oct 2025 07:31:47 -0700 (PDT)
Received: from ehlo.thunderbird.net ([149.62.207.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b4869b57f0asm692110166b.77.2025.10.04.07.31.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Oct 2025 07:31:46 -0700 (PDT)
Date: Sat, 04 Oct 2025 17:31:45 +0300
From: Nikolay Aleksandrov <razor@blackwall.org>
To: =?ISO-8859-1?Q?Linus_L=FCssing?= <linus.luessing@c0d3.blue>
CC: Jakub Kicinski <kuba@kernel.org>, Petr Machata <petrm@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 bridge@lists.linux.dev, mlxsw@nvidia.com,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Andrew Lunn <andrew@lunn.ch>,
 Jiri Pirko <jiri@resnulli.us>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_net-next_00/10=5D_bridge=3A_Allow?=
 =?US-ASCII?Q?_keeping_local_FDB_entries_only_on_VLAN_0?=
User-Agent: K-9 Mail for Android
In-Reply-To: <aOEe3XKr25GNGZpr@sellars>
References: <cover.1757004393.git.petrm@nvidia.com> <20250908192753.7bdb8d21@kernel.org> <3213449c-57bd-4243-ac8f-5c72071dfee5@blackwall.org> <aOEe3XKr25GNGZpr@sellars>
Message-ID: <171B368E-D819-4AA9-B343-EE1AE529F8AD@blackwall.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On October 4, 2025 4:19:25 PM GMT+03:00, "Linus L=C3=BCssing" <linus=2Elues=
sing@c0d3=2Eblue> wrote:
>On Tue, Sep 09, 2025 at 12:07:43PM +0300, Nikolay Aleksandrov wrote:
>> My 2c, it is ok to special case vlan 0 as it is illegal to use, so it c=
an be used
>> to match on "special" entries like this=2E
>
>I'm probably missing some context, but why would VLAN 0 be illegal
>to use? Isn't VLAN 0 used for untagged frames with priorities? A
>priority tagged frame?
>
>Regards, Linus

Sure it is, I said it in the context of the bridge which doesn't have such=
 support=2E

Cheers,
 Nik



