Return-Path: <netdev+bounces-200520-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E850AAE5D39
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 08:54:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47ACB18945DB
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 06:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 630DF248895;
	Tue, 24 Jun 2025 06:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TskGz7C5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96D424887E
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 06:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750748006; cv=none; b=Jb7M0O4PcaTlqy8kTgrOsdb5ueCEVYjYaQ7CGqCa33BduRjsehCNcdpAT7GZReP1V32UfQWfMtUxWs7rv6nsOob9LBn4RGAWfXasHkToETvwhsUAIU1a6JfVfOzXe49bkrDpGjU2CfVuA2cdHBPizO2YJoDewifg2BEPrEKkTkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750748006; c=relaxed/simple;
	bh=idJndfXyzYqs+HMPCoBbF7wxxUtfKhs2ipdP48/6yK0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mrpSChV522I/wqn455fuR0YiFqZ8VHuzf3fepFBtJ/MC3ms7e/v8j6LbROlkOWtaqkeoQHAl/ue1f6VeIsJBUtm1N8tuRNQKC//lekDAtWXmBnHXyW5ELX3SwOLRzjf5rDprL1fU7naLHm9G+q3HQYEDPrCnGegDBi1Aq4SVpNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TskGz7C5; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-315c1b0623cso2057192a91.1
        for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 23:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750748004; x=1751352804; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YSm92Vbme2k8tfUVPmnbL2tA43ofuQNiw1Zxil+TGnI=;
        b=TskGz7C5ARHeSUG/eukv3Ks87/my9QRR/DcROTzJWg4I55Ebma8zq0kU4yYuEGsbR1
         Rq46xGRLRydNoZ/GzJsuc0172FYrFU01075i/gzGTjNW3OPo+P21KFdgAh6pOljAUAOz
         OXH3TbYDNY7uQe4KlYIGi9FD6gaSAcI9ecLmuXXAG2j9pmCsZ8wHcQ+qd1mBZVgOa7Jy
         tBzFEUju34Ih67nnUk5IlBZRFRUtqZSn+NwDHNKTZ9Qivn52xxmd+QoveHt8l2eftvqT
         jtWv1J+Oth3yv/vQfbkkOCiygBkyg0uH4kt7TixGGlwCGBXS94qzXWoH0RBz8t0RmV42
         jyGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750748004; x=1751352804;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YSm92Vbme2k8tfUVPmnbL2tA43ofuQNiw1Zxil+TGnI=;
        b=I5ny6oz493N0yPXpGH6kEspDCBfgMt46pQVlJQ8D85UQJxj4NDjeB+7IGjdk8fLuVM
         /DDhV4Ru4EMgRwCw9HRWjz8fT8qDnPqxeHVfEVn0TqIJ+AGSwy2f4hyAtJC0sOeplGa6
         QYHl7clTd8zoiduV4p3Xo0nBos9H1N6pXwrH8YrGfV+W6IGMwqRlYBbAguvl44vIZgTu
         6Z/YySHf14+ix0bjXqGlU3SoS+HjMjdBhgaJ7gdHKozFHtzF1T1lUl2611K7Xyxq8gre
         6lvJtoXeZOaExggsvzS18A3+kzWsy6usyQ44EItLIEe1NAeFIftrK0uDEU6AJwjq1NI0
         FrMA==
X-Forwarded-Encrypted: i=1; AJvYcCWBXwuz82uDtmdJbcK62bsZcGHla0wgcGbfuPTVcgFM1BsFnUjQSF6sPcxXm1hy41QiTF+MH28=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKKqsXL9heod+LUJbdzT5GDes1qJQLS/w84XcQehFT1Rq1zS5O
	6c8MgoicahomEDfowebDUDF1m7yWm4DRKGcbsWtkitx4zDzStMi9vqWiWElq2OzM
X-Gm-Gg: ASbGnctrwMmIR/PfsalF8N+0ADLXl/9AvIjEt6wUgsC0i2FVwaOTILsE8EakE6prIpj
	JU8yEMstBJu9deohmVhUW9C8wb40WDl7jQ+YKTV25EBweNKQIT826LlohDTmZR6ymyf9OmR0hBk
	DeBpjhrQiVuMQrqfT1fOAKgqoUeQ5ENa03XgTSdFLe8sNoPWDlEJrXp/0gXtVcMrBsv0wDQgHLK
	Y8yAJLg60OW+jLVpyeMXpsI/UrWfLae9CwCLIkVY0TRwBtYN9f3veHTIVuW08KrNdOAezA6jZqu
	od42APMdA6SFDUrBtjaazcRGtJQtNU/TUc5kdKnlBiqKnzLWxHQLSpjYGyTvt9oVUqk=
X-Google-Smtp-Source: AGHT+IGefKFGTxupMgMB+5vKxhNF5P7SKpaLJmUZfxxUjdBB9xe8wuL2aJkfdBqjf3c4MdTZ3aOiDw==
X-Received: by 2002:a17:90b:384e:b0:311:e9ac:f5ce with SMTP id 98e67ed59e1d1-3159d8c1504mr20929450a91.21.1750748003958;
        Mon, 23 Jun 2025 23:53:23 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3158a2f0987sm13657828a91.25.2025.06.23.23.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 23:53:23 -0700 (PDT)
Date: Tue, 24 Jun 2025 06:53:17 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jay Vosburgh <jv@jvosburgh.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org
Subject: [Bonding Draft Proposal] Add lacp_prio Support for ad_select?
Message-ID: <aFpLXdT4_zbqvUTd@fedora>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Jay,

We have a customer setup involving two separate switches with identical
L2/VLAN configurations. Each switch forms an independent aggregator
(port-channel), and the end host connects to both with the same number of
links and equivalent bandwidth.

As a result, the host ends up with two aggregators under a single bond
interface. Since the user cannot arbitrarily override port count or
bandwidth, they are asking for a new mechanism, lacp_prio, to influence
aggregator selection via ad_select.

Do you think this is a reasonable addition?

If yes, what would be the best way to compare priorities?

1. Port Priority Only. Currently initialized to 0xff. We could add a parameter
   allowing users to configure it.
   a) Use the highest port priority within each aggregator for comparison
   b) Sum all port priorities in each aggregator and compare the totals

2. Full LACP Info Comparison. Compare fields such as system_priority, system,
   port_priority, port_id, etc.

At present, the libteam code has implemented an approach that selects the
aggregator based on the highest system_priority/system from both local and
partner data.[1]

Looking forward to your thoughts.

Best regards,
Hangbin

[1] https://github.com/jpirko/libteam/blob/master/teamd/teamd_runner_lacp.c#L402

