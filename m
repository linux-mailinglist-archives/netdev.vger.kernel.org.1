Return-Path: <netdev+bounces-179894-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B80A7ED96
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 21:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 289E33A5B69
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 19:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70920214A6C;
	Mon,  7 Apr 2025 19:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EnER7KqT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A8D1A2C04
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 19:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744054577; cv=none; b=F8DK2B2nlOKWhMDEbnMbCm1koGMKfHhCuEoS6fPE73Z6EyzG/uUf/h6rG8ZQefbAwxBUfn1BbcFefNt4EcUN5kYRipLb6A60uTxBv0gZwZdIakSb+opBs3jiY3guwPZQj6JD27QIQ65t9y1npAwH7to7PQOBloVe/JElY7Ssx14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744054577; c=relaxed/simple;
	bh=0Wma5GAQAbhTNO+EbPhHxfJ3kZFHw/8hK7d7SXuQtKE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=UxFLkzYnnasgNik+fralpa2J67SOvHjml8H715mpOrhJvt1miTTkgCcoG79f710MSL7+ltXY4bVkinyklKINSCE48zzL35fEoyldj0Qi61nC2WZ1U5vYfSzpZvhUdseHr0o+PO+E4U84Gx1SNqaaO69uclgIAbQF2RQK1HZYFFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EnER7KqT; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-477282401b3so49144801cf.1
        for <netdev@vger.kernel.org>; Mon, 07 Apr 2025 12:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744054574; x=1744659374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OtJhg2wVt58IOTYm6UtZL8cYYptEWgrIdCGYLK24eZY=;
        b=EnER7KqTLlLSF6OVRfQPXuIgKcqpQxDRbpZeALvwXFsBze6ixW0J5LWpio9x9W27zw
         2mF/Gc037jiaYVJ6XOqNqU6jJgYCcLsf2RCVNoMdpYkZOV3D4F23V6mONLz9UbAnQrHF
         dHxg0LVSJ8TIU4/eWCz5rPBuGFONgPntpRMvplCXeC+9VYsTq7qEFqc7eoiXRwpU9uvx
         NA4Ozypi/oFiI7oKl/sCfcmYm2eiTel5ObIkV0GP92+EzGyy0uqPWQUQI/+dlU3E5Df9
         bLtwv6yVixYORx/O3jeZlTzsQHEwPieeiENk5zWw7WjxEEK1s9m0D9M0K/aLGgU9IRpC
         xyVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744054574; x=1744659374;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OtJhg2wVt58IOTYm6UtZL8cYYptEWgrIdCGYLK24eZY=;
        b=GEmeIgPpvxdwIqRGUgaeHjQwVwdZH7bGf0bCvit7CdrshVITyQV0u+6TE3AK7pHUy7
         2ZyhR6OGzMq920DQj54BF4r7K9cZakAv5gU7zJhq8OFA4kNv38nEiMMzfSBbwYgmJ9GU
         py7ochrhINU4LYDMXWjA08XX0CLjTdk1qdAeQwXf7r6nuGXVpe9iXp93WHYAl3Wrr1sw
         4pY0YLZSpJieJdz4vGWVabwJPXflIo1aTd13Fd81wyjEQShOrY0t9a9phMK2rHJWV3yi
         gxDFmy0q/4Dq1uA90ZtklWi11bKFUP+s7vhlY+Y2IF9VROuqPDK1yef7RteybyrGUcWG
         7riQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjoZWKJmSJCNWzNA/6fO+3l/TT3NFe6n1VJOFZHz1hxRv8L2hRnGwNSgd+MhpZheom362apYk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH/bYJ99HllqJqDkGayLjBNZjlv7uVuCes+2uif6qc5bzyQ5oM
	PzdHuDFGVWZZ8vlb+Z9gSFNK3ZS8g7yyOwwa0t/SJKYIZ9azPIEN
X-Gm-Gg: ASbGnctQnYo0Fzp1+IK25rNJmv2GsJ3WbU4qD0Gim+60xDl9EulR/wyiatCmepz7XwA
	V6ZEZ+sN2uHKRi+yigqIyWfg9ph9DLFpOK75o5Ncw+oJ/dyHbMrbXmxiA4cH+X7WPFXA16raCJ8
	pr/G7x86keSLnR96jFoLiGwrUQeOkjlh0NWnX6uryi6REjvAzflnvYR/nzZahrNB2vlGalUbxTr
	SIE5s8KCw0hJIpYkWZBA0Wo5vpElOE2yv9q0spMlGhkpSiOIDpHmPgn2dCqYqhHwp2pAode5gHG
	vKFQbUpqKfbof4UFUjYgH+Bs+THaub8nwOmlN+kFNNwLlAwCr2JN3MDAbHBxt3P7LTs0qZwuuDl
	T7jYokoJDQfsMlPxlJcjAoQ==
X-Google-Smtp-Source: AGHT+IEcYUKjOM8tRsjAN5iKPJFLHtWYQnA/dE0kBE+LGZLwZn0Ntki3iX5vdqpvVJIcvigP2E5icQ==
X-Received: by 2002:ac8:58c8:0:b0:476:8825:99c2 with SMTP id d75a77b69052e-47930f6f16cmr112326861cf.10.1744054574637;
        Mon, 07 Apr 2025 12:36:14 -0700 (PDT)
Received: from localhost (86.235.150.34.bc.googleusercontent.com. [34.150.235.86])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4791b071b42sm64531971cf.27.2025.04.07.12.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 12:36:14 -0700 (PDT)
Date: Mon, 07 Apr 2025 15:36:13 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, 
 Willem de Bruijn <willemb@google.com>, 
 netdev@vger.kernel.org, 
 eric.dumazet@gmail.com, 
 Eric Dumazet <edumazet@google.com>
Message-ID: <67f4292db9fed_3a74d529434@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250407163602.170356-5-edumazet@google.com>
References: <20250407163602.170356-1-edumazet@google.com>
 <20250407163602.170356-5-edumazet@google.com>
Subject: Re: [PATCH net-next 4/4] net: rps: remove kfree_rcu_mightsleep() use
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Eric Dumazet wrote:
> Add an rcu_head to sd_flow_limit and rps_sock_flow_table structs
> to use the more conventional and predictable k[v]free_rcu().
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

