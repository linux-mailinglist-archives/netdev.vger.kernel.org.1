Return-Path: <netdev+bounces-219506-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF6E2B419E6
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 11:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1228016183C
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 09:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 140CF2F360F;
	Wed,  3 Sep 2025 09:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q7euBEf8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449E22F28F0;
	Wed,  3 Sep 2025 09:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756891563; cv=none; b=p85YUkUTfaS4tixXnshzvUaK4BxNzHj4If68h6Kml4ze1TtxOAcfyNBt6O+1oOdEt9z98DaRtzNaOAlSeuMn7eGAQAakP3P+DvilcIxNNgcUXCq70FF2tQW0xtUmmtsNPeAYVGG/WGNBIf7yNPZc/h7/KGwvNmxK5+bIVZ6jVUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756891563; c=relaxed/simple;
	bh=g+o3S8dQKE3xX5uzFSIIJknkJOesvFWLGaouxBM94KA=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=Rd9fICQGeX8zqVF6j32YvmJyLt0kZoC3y7Ib7+uBGe26GFE58ozScXaILKu7oPo4PhKYir/h88KQKd2WOYa8sPz6FJAWlF5XfbORMqXeqNiNYjV/fFzeOU8ta5MFwtvZOZ3GAQLXF515AbQf2O9Juf9fwwIi1SY7KbqrrHfm5BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q7euBEf8; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3df35a67434so185241f8f.3;
        Wed, 03 Sep 2025 02:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756891559; x=1757496359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :message-id:date:in-reply-to:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=g+o3S8dQKE3xX5uzFSIIJknkJOesvFWLGaouxBM94KA=;
        b=Q7euBEf8SnVIwaoe6GJmDVcBqD4mf6iM25gx9+CK+0mV1ZocHEWm28j8oGQvC85jve
         7mXxSkb8a4R4r8q+KAYOsu58iQf2ya+5tcStsME4JLjbnD4WTZWPWllVeBmXqGlqIR7c
         AB+6NTr7TLez4nj/Go5uxoJqUOIGdoWa9dRfeHcgzLk28LnWhbgZe/sJM/RMBSjYbX+/
         1TE6ML3QK5YqYeWJQQAKyneN3c/cjEGV2rWYmm/LCfBaDJ/ciVNHOW4/J8hFpo69VpdW
         EA80brhL5XCG69k/QaoOYFCGvr+W7Va4FkRp72MEA88v1knfU5/FDzRjJb3m/NcKQcb0
         9jWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756891559; x=1757496359;
        h=content-transfer-encoding:mime-version:user-agent:references
         :message-id:date:in-reply-to:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g+o3S8dQKE3xX5uzFSIIJknkJOesvFWLGaouxBM94KA=;
        b=Mv3vXf1Y6yOlItHQc/czoeHA10ekkidNoL6mDihU44Gr4s1Ji0ptxvGDRU18fbrS88
         CBRJlAphfIcqSKHvzcn4FWtpoGZ3axrLsSBsOZU+VMIXvQ8N8NkbLhYJvJPAW+frQCdq
         IgnpHcVPUTd0W/Nzw/04b2VdmE1Hp43aHEGQ7RZ3KPDcHpCOF5EpmS/0anj9BuVECbdU
         Y9C6Wx1/mVCtr8Npnbg2XudbiZ06K9/Xb6d1S1+UYUpXLMr6VeuHBxSANgMiOocCEzqb
         W2w83nTkgA/NWLKkRHcEvW8TKOTTyDJHyvvQ1Hbj4oEUdKGfJ8eOA1lkFWWCOzkYE3/p
         JrwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRHTwxcGJjwxS7Njb0FO9TqhC5w20l92vNtjePXN+P2cnpqmbdU6ZeqWge1jGENqTd0mFtL+V2@vger.kernel.org, AJvYcCVSkBI8YHSDcFS9cCbxvUoghWVOFSP88v1iPSPNFR7FJHwqrdLdkh+I7fv8izAb9EoILOvHzEgYNoqw8s4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpioAtRwKztVJNIrtttRU3kip3F0E4IYgv7brUSD+FV4vdT6zc
	Cp9SRLZalSqw/0aIBcFNOImn/SZMinI+S4uM79nQpDD8RTdOBllL9H1MQa15L9ZK
X-Gm-Gg: ASbGncuZgQjNk3yuZ5Ad7vmI8XMLHfyp6DoM5bhn/n2sw4tGniufaKUSozBT5jvI6vz
	5SFcWCo6W+HSIuBzc7KEDaJSArdSifcJYnGeMWY1GcTTlOGGVKyvgXrL16o1a0b/Nvlu9asA+6X
	d+KUq13iapNc/LlebFvgrkXLN9NE9oxRrth02leA4x1zXJUzFi/6AICEWSi+CIUng6vXb2mvaS8
	Cn5lWnUuFUMVagqjjKW64cK5uECghiKlh7tMUIfyYNQfZW803owe/7q8gVhe4+YAaZKAQ6GMGyu
	tl8aOhqkYQNyq3r8KOTeNC8BqwtxxifOKHK01y6/bOCq8yRFUZhccyvBgHahdtmUDmvlCKH4AJX
	8F771LjwhciyGLETsdOEyEV2j8xpoklyCsY35wT7VAls+bj9BhMrYr+oo424izQ==
X-Google-Smtp-Source: AGHT+IGQiBSCmiqTBxizTmCxQcY84vqkIOOlgW/eXh130LIO11F8u1GDeRiPCtGygHHVmt+1Cdqrvg==
X-Received: by 2002:a05:6000:402b:b0:3db:c7aa:2c19 with SMTP id ffacd0b85a97d-3dbc7aa2dfbmr2691721f8f.26.1756891559107;
        Wed, 03 Sep 2025 02:25:59 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:599c:af76:2d34:5ced])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7e7d23b7sm231360845e9.1.2025.09.03.02.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 02:25:58 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: =?utf-8?Q?Asbj=C3=B8rn?= Sloth =?utf-8?Q?T=C3=B8nnesen?=
 <ast@fiberby.net>
Cc: "David S. Miller" <davem@davemloft.net>,  Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni
 <pabeni@redhat.com>,  Simon Horman <horms@kernel.org>,  Jacob Keller
 <jacob.e.keller@intel.com>,  "Matthieu Baerts (NGI0)"
 <matttbe@kernel.org>,  David Ahern <dsahern@kernel.org>,  Chuck Lever
 <chuck.lever@oracle.com>,  netdev@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 3/3] genetlink: fix typo in comment
In-Reply-To: <20250902154640.759815-4-ast@fiberby.net>
Date: Wed, 03 Sep 2025 09:52:38 +0100
Message-ID: <m2wm6fzzmx.fsf@gmail.com>
References: <20250902154640.759815-1-ast@fiberby.net>
	<20250902154640.759815-4-ast@fiberby.net>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Asbj=C3=B8rn Sloth T=C3=B8nnesen <ast@fiberby.net> writes:

> In this context "not that ..." should properly be "note that ...".
>
> Signed-off-by: Asbj=C3=B8rn Sloth T=C3=B8nnesen <ast@fiberby.net>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

