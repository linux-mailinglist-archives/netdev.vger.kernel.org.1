Return-Path: <netdev+bounces-186704-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D65AA073D
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 11:30:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16C3B189B6D2
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 09:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B7CE2C10A2;
	Tue, 29 Apr 2025 09:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ByVtVlQg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C18B2C109A
	for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 09:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745918852; cv=none; b=m52mwu8L/xLwWsLXgeKN/V63yg/WiulZ9RQDLdJmYKXjIJ/+EJylwvNkQqgS19VimXAHy9zKJsJudaM9tCm28f+g4L/N5L4IIuCLE+0vSIev5eUaV8DCRXpSd24G6p8xLhTTGngSRWA328XUD8INEeg6ktitiLIWMFxCFtcDJ9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745918852; c=relaxed/simple;
	bh=7Txnm0yhXX+EaAXh33Xu0J3tu8ejPJoiSoOohoF4gxM=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=GKi5FAWNHVZi2g2trbz16eDh2vfwQR/bb5tAp7GUckhhuQORRehhyX5BcEVt435zvshkDh8a3LjaALqb8ZTlUOvsu3vbPIt/unUeQQ/qiZjXK12ltlpWouct4Vv5KhTVcWE3FGHYveok4iFPAXTdlhABEfVxhmeQ0m3rtFK8ywU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ByVtVlQg; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-39ee57c0b8cso6648604f8f.0
        for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 02:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745918849; x=1746523649; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7Txnm0yhXX+EaAXh33Xu0J3tu8ejPJoiSoOohoF4gxM=;
        b=ByVtVlQgoZltsW//yjS85hwzmXh5lln+l/uUR4/xs4bSMfe/tZBntHjaVv2rPtyXNm
         nabgYo9XaG3fVl/QhY5oQAU5Y8GnXGB4J/nZRS6GnYrHoLdWhoY6d0HRcjYgpZowiE4F
         KVej0a8mKH2I2yK0gy/YT3V7ImKfSeGvndNsw1+uc69UXtRfZIfZUrCpa5IwMZXs5r2K
         tfdVzwhibX5BsjIGTPjCN07XmieDwxhrOSn8Qdah+yY08BOL6kvTYznPFKupcE6sjv9n
         4CoGfsUkEXVDz5JWoof7z83/HnTVjwG2fFVUx+Mc4ah2JibiGz2RJzdWaoQCOKZYkX5n
         vVCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745918849; x=1746523649;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Txnm0yhXX+EaAXh33Xu0J3tu8ejPJoiSoOohoF4gxM=;
        b=wRg0ZuI8xT2pAqJBZrYwMGVNN3oHqdEVnS0t+QohLcIGy271um7nB5zuNQ2FZ/4frR
         mHQqHnDUp5BDd0P77o1LJsLy0fatCNjMN27Pro8Le6N2dIBiu7HlvLlAiDBi82XZ4JZx
         wCo8i4h7dAVqWmRQc3hJ9f9+o0x+MRPKsMBL8wRSjvLN07LxD72qlyS5jIDmhzzkEtHr
         qBWilSk14/sfCCLHQSTW5vhWFo6FSX3/GQDqJaaZYYVK/Ih3LfUKFoK7wol+yOXnQPBT
         g5AzvvbYqaJRAY6VyEH2jnbeGTYvDsFcJ2TZhDZwSXBKTTTEt0vKzBxrzeinr7UVYx9k
         Uy5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUhCXL4QxHHZowjXzH2chIScFSWgDsatal3VNhZPPcm1A/VusH0WcsIhSF38tMUwCS8Ij09kfY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxox+FzOPKTwfLgsUavaVbFqIxEyP3VKl5HG05Y7sfD/WqCKuiZ
	F9xJ1EH0CiZywUb02nSWfTGmyxG83deWhonZHIGq3g4C3nXdqxFK
X-Gm-Gg: ASbGncscICraD3jsI/oV8MRlkE5WLy0bQSpPQ+XedpfHJuRLbtKeRwgxN31U5av/ehv
	mR+qIXxSZ7qW8Ybkgss9SOWmRd2uEDErmM7dw222ekHnOsSTsR6YgZosIIRcYc4mTNR07iLc9Ah
	qGIBSrO4CWTL64M/32ynJnoVHnGeqpWxPft+RByZ+DryW1mtFN/JdlVW7HRWn4YzfHzvkFAh+/Q
	s1CTEQMkbkEgI2m+TcmCmEjzSeHb3cuRk0EOvQTEO2EzIsf/fLk7E28LcTCtQVrSZVvCdff4Hzl
	b6jdiH+lpTdNfLXCDrYZRB7TnPOY8Mv+brBa6yxa6UWZxgf2vBycKqlrGr5TDKL5
X-Google-Smtp-Source: AGHT+IGx8iNqpleUYZC8FWfnHAVFGxEFXaPR6rrshUDaCXZHt0/jRT8Z7XbrN8UECofSw9lBrLAZyg==
X-Received: by 2002:a05:600c:1c86:b0:43c:eeee:b713 with SMTP id 5b1f17b1804b1-441ac88c275mr18663445e9.20.1745918848734;
        Tue, 29 Apr 2025 02:27:28 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:251e:25a2:6a2b:eaaa])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a073cc4679sm13496222f8f.58.2025.04.29.02.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 02:27:28 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org,
  jacob.e.keller@intel.com,  sdf@fomichev.me,  jdamato@fastly.com
Subject: Re: [PATCH net-next v2 08/12] tools: ynl-gen: mutli-attr: support
 binary types with struct
In-Reply-To: <20250425024311.1589323-9-kuba@kernel.org> (Jakub Kicinski's
	message of "Thu, 24 Apr 2025 19:43:07 -0700")
Date: Fri, 25 Apr 2025 10:27:37 +0100
Message-ID: <m2h62cr3p2.fsf@gmail.com>
References: <20250425024311.1589323-1-kuba@kernel.org>
	<20250425024311.1589323-9-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> Binary types with struct are fixed size, relatively easy to
> handle for multi attr. Declare the member as a pointer.
> Count the members, allocate an array, copy in the data.
> Allow the netlink attr to be smaller or larger than our view
> of the struct in case the build headers are newer or older
> than the running kernel.
>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

