Return-Path: <netdev+bounces-159332-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B5CA1524B
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 15:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44EF03A67AF
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 14:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0FB7189919;
	Fri, 17 Jan 2025 14:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dA3skjkt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C15D15FD13
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 14:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737125995; cv=none; b=QADVuA9zzkVrYiTV3AKpWYRMSJtOn4dO/J+CL/BUeVB6HJJWPobmEdt3A/cG461jKVHkE5EBcKm/E0Upbo0M3vU5PKfXXP7AhSrJ6XgI3vRbzPeqErgUL/T4dDOHa+RrDFggZ6k2dpJ1EnJxMBkW8gN5KgbPzALBr8Vk0p58ZeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737125995; c=relaxed/simple;
	bh=FYIdVyLJ1VEZanD40elISQhj8UBKvnUmQ14RDqI3Rcg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NscKcXuxu7onCaCOzWfX/gDxAvNrtSLg3XbDoIev4PSvt9fzF592VkA4RT33qn66ZbJd0yQ7AGmiADf48DsAbudsP6vPmq00jYKg5jkg0ohuSxtyIOJWXXSKbDqeDohpeTo/XWRErd3jz83FH1p0QIiDxNx910xiU18xh339/Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dA3skjkt; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43690d4605dso14837725e9.0
        for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 06:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1737125992; x=1737730792; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XoY2CmYqDhwCjr+LTaQT1CEx+jVsjk82eanBRDuR1qg=;
        b=dA3skjktSnO+ewKKOne+ZBopa1eS5wgGVcJKpt9Cb3xR+luFftABtf2wPU+VpwaHee
         IeUkxlNYzimWj202H6HiFJo4D0sgEw2Q/5YLCtprzNAgh5ucIROD7jtGNJ0XXY9IV5FK
         fgzDaBqg/ueKh4za5lgOHOs30D/MRLWViJQvDemnYuEBT6KZk3MG3kq7tMxaVnDTSi6k
         IQueHPh/rrdus/yQ+YmMhQbvl8jORP477NL0DrGDMIMf67OS/hHQqHDCa5EoiFjvntrp
         zKHyYS2OopY3HBtKcjTVbCHPfy1mSuhSdM85iUdiBDPxxDWLx03p0TQZM2lsIPRR9ZNe
         gcWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737125992; x=1737730792;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XoY2CmYqDhwCjr+LTaQT1CEx+jVsjk82eanBRDuR1qg=;
        b=gU0fBsnXi8M+rnM2totrSm+PLjtJ0KVbFyAMIwWuPUPkMbiV2ALMo2OOaDBvWat7ia
         73srYL9D7UCDFceTP2CujNnHAjAqA1NqEoyrb1VFxw/McgWfHfT4NwQBEGRknNwxkw5B
         7gvAn5010hOTus/PmyFWeNZZpn49QXiYsfKUJQ5GZ1y53Wlvz5F/spxVxaAvZ3mY1GW6
         x57WD9G7MQgOw0G7uADowuP+g+ZRxCNLvAiBDSgbw8Pz6QpytQ0VHOYFnBRfn3CM81l8
         eKOTpA0qEl6Okr6GOa2d78YOSCjVYgsvxGsQ9ucJLekyVAcjSm3+HLERik1FpRTA7CBX
         EHOw==
X-Forwarded-Encrypted: i=1; AJvYcCVocci9Eu9RVpZzUSnUw4Y8f/c8h15Nz06L5ZoAjCSioQpmZZxkIMAUpNUfdDYsIN32dTDS/po=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi7czckm6NZZozITwPXJdO7BxZLgXxTl4XUhlcgavRPyyqnDNk
	tvuUEi4NMlagHetfB1GqoS3oK5FhdSxn36MYpkYzxwoVHiPOwsJQb9Egn7Gze5I=
X-Gm-Gg: ASbGnct9X7YNoVtCoUWCcxFx5Rx7h3vFXvTll2PT/IySY/ZjRc7TZNUhQncleiCGzho
	glNDUcszwwN81RU3sjLdwIfytI2sUms6oSdfK4RfFt269eK/upsYGl5mcVLOHjACLb2z2Msw8Xp
	TjMWX1fZiJAni9Wvl6K9vfeItTvc6QiD7z/QUYP1eeuYXrgwM1DyYuiD13ZEFiB61KwidbQDS1Y
	+aD8uj+zmU1sfXxc2QQ7VwTNZmaWkUrQZK9OnhELXSjyIpg/j0CVe6dZgK7Q+M3sqTWmA==
X-Google-Smtp-Source: AGHT+IEeRJ9cpKeNPyOpv6YqDFfsJM6JExhw0J3WkruNYdK28qTCi2QUozVixRXMXz9wRrk9NPLQtg==
X-Received: by 2002:a5d:6c6f:0:b0:38a:9ed4:9fff with SMTP id ffacd0b85a97d-38bf57c070bmr3026621f8f.51.1737125991738;
        Fri, 17 Jan 2025 06:59:51 -0800 (PST)
Received: from localhost (109-81-84-225.rct.o2.cz. [109.81.84.225])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf3275556sm2751940f8f.72.2025.01.17.06.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 06:59:51 -0800 (PST)
Date: Fri, 17 Jan 2025 15:59:50 +0100
From: Michal Hocko <mhocko@suse.com>
To: lsf-pc@lists.linuxfoundation.org
Cc: linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: REMINDER - LSF/MM/BPF: 2025: Call for Proposals
Message-ID: <Z4pwZkf3px21OVJm@tiehlicka>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,
this is a friendly reminder for LSF/MM/BPF Call for proposals - you can
find the original announcement here: https://lore.kernel.org/all/Z1wQcKKw14iei0Va@tiehlicka/T/#u.

Please also note you need to fill out the following Google form to
request attendance and suggest any topics for discussion:

          https://forms.gle/xXvQicSFeFKjayxB9

The deadline to do that is Feb 1st!

Please also note that we have decided that there will _not_ be virtual
attendance option this year. Nor we will be streaming sessions. We are
sorry if this is causing any inconvenience but we have concluded that
we will use our constrained budget more efficiently this way.

[1] https://lore.kernel.org/all/Z1wQcKKw14iei0Va@tiehlicka/T/#u
-- 
Michal Hocko
SUSE Labs

