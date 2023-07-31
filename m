Return-Path: <netdev+bounces-22839-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A6B47698D1
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 15:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D9141C20C1A
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 13:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D833F18AF3;
	Mon, 31 Jul 2023 13:59:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51A728F8
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 13:59:52 +0000 (UTC)
Received: from mgamail.intel.com (unknown [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5DB3525D
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 06:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690811970; x=1722347970;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iFIUuRDdmDRfX+cNwyK91ImAF4/+ZUITGNP5R319rdk=;
  b=WhpOAloLwihwVyaRKuW+w4CwnYIB/g8cQANf/LDQ8nHdHxgZYvsdD3ZV
   zuK8tQXGUztJdHIU7ONp9i0PAt3Fz3TpMBE7CTM+ulppSHm6hyVr5rMGC
   dAigNAzBC83TE88h3OACR2f0TljfEFt+NGPMP1Deea9kn+lip23Z9beAQ
   cDTZDTzH8vjVhC1crHhM/mNOqgnfL4BdLtaQCv44NiHaEE1YnNWFWsMRd
   CqFMBAaN54twWtC8+CDSbfeHrYBT0KTwOHVUSUXmpjABTAtw8EMKOOkQy
   TmG5mMq10gO5Mjfy8LkFJ5uwSPNfAjZGV43OW3+W2/TSPHsOVH1UGuLL9
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="435333549"
X-IronPort-AV: E=Sophos;i="6.01,244,1684825200"; 
   d="scan'208";a="435333549"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 06:57:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="902148313"
X-IronPort-AV: E=Sophos;i="6.01,244,1684825200"; 
   d="scan'208";a="902148313"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP; 31 Jul 2023 06:57:45 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 31 Jul 2023 06:57:45 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 31 Jul 2023 06:57:45 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 31 Jul 2023 06:57:45 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.109)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 31 Jul 2023 06:57:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CKNOdFKJPYgc1AnYEP2v8xAzZsAfFi5wYmlrQCb5J5l4HDODdRNpqFmZRLoNVrTzVeiPuicHS3QEgfBWE83BWWx3qbKqru9zkcFMlMIqxEWQUtU1mjju+JU0xdj9wkYOhJj7NnMWQAFyKrjnEM2fdG2k08d/f5fFO+DZMjtccAbAJFlCafoeFYdMKu2cWkuF8BGAFll2dgpMDdGillKU+ReUcK2zwrL7pUiMeWLxIBjve9UYhyw1S2RwmstzbH+8aP8tc1nhtyPM5xPPDa7W2eOUM9VTMdQUcUHmoXoYyjssesclb8CY7KvHl3WZfjCGxq9jY8dU7dzbrdHjg9s+eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iFIUuRDdmDRfX+cNwyK91ImAF4/+ZUITGNP5R319rdk=;
 b=ao2uLh4dEvCBUy7vx3oe/VlJu+eIOgV0zr0zbR6MjeQGL2S58uN9JkQa2rNysYPCO6ew+XSlwQShpPEy428HJ0n0ql+6A5ZsZsRJrQ5Mm78vUSlGoAXVr2PElvSaNc/TwizrJYDV8O+CIMiUiAbOcVEeXpt1AXk5zMWl+yvf7IRqHHxfYX/++Cvg2bn5PsrYDxEhYBh6iHBH58QTL4qp6UW4aa/CpPAxit9n7I7W+WYyVQTmrvLtm4+jGTRCtGmM5q5XWWD5BfVeKhjt8XFil/z/4e7gIAhVmclQcKLnow+FGrvOYKyd3fFJDgGsBM9GzcU82sdDWF4DfF2PUCjnNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2731.namprd11.prod.outlook.com (2603:10b6:5:c3::25) by
 CH3PR11MB8212.namprd11.prod.outlook.com (2603:10b6:610:164::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44; Mon, 31 Jul
 2023 13:57:43 +0000
Received: from DM6PR11MB2731.namprd11.prod.outlook.com
 ([fe80::401b:360a:f15f:b0e4]) by DM6PR11MB2731.namprd11.prod.outlook.com
 ([fe80::401b:360a:f15f:b0e4%7]) with mapi id 15.20.6631.034; Mon, 31 Jul 2023
 13:57:43 +0000
From: "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>
To: "Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: Grzegorz Szczurek <grzegorzx.szczurek@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v2] i40e: Clear stats after
 deleting tc
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v2] i40e: Clear stats after
 deleting tc
Thread-Index: AQHZwGZuYYYvwIAy3UGjHNtk8HG2m6/P3gYAgAQOlYA=
Date: Mon, 31 Jul 2023 13:57:42 +0000
Message-ID: <DM6PR11MB27317F1D61E7B50967DE8C90F005A@DM6PR11MB2731.namprd11.prod.outlook.com>
References: <20230727084335.63856-1-jedrzej.jagielski@intel.com>
 <3187ca51-d1cf-d175-5740-341ab9bc46d4@intel.com>
In-Reply-To: <3187ca51-d1cf-d175-5740-341ab9bc46d4@intel.com>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2731:EE_|CH3PR11MB8212:EE_
x-ms-office365-filtering-correlation-id: 0501e294-eae5-4930-924d-08db91ce1c6e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FZEbGddy+/qm6Ekn7W2XbaVDQRhBK3VBLf4Lr0pTlHMKfDUgLrc9eAj3b6cJxAZHml98omHGjkRs0tyHbDcm9fgywT3t4VOBqnyv5PZAmbguj/cQbu12YVxAtpBhHghxKbdR06oLYmEc8qAmI5vFx8Uxi3hv9M2wJGkXcbXbbve0nwsMlKkY7IsSv+cHftZhvIsEfqE+xySaIZgb4tCXT0lXoaA5Zj22dhhfTkSLocwSa9yHL80AyRUgH2EhzHhr9HBVoU7QwOdsODcqqQTyn71zABQWeg/zPuCnm/CfRueUzKxpCsHajT052d7PcEQX22rV8RPhoK25dFM2GlNr0SjjVrg1jvZOwUfj1DQH0lxKa8KOwTNne8gC+2Td4+i+GY0WyOLfWLWOn8X1bN8HfspxEQDRXUSTStDYNXdue3MX3e4mnJSK4bFgeQGpsS7pf4iztsOu20RGfN13sG7lwYgmri8UfUubh5pDxXvY6g/OzZw4PQpNj+42dyDPKDLot0SnBOpa5kAcxWR5eNMvh1uEfdJIV4JlMhN2v3SDaZAG36Gz/qdgGAKFuV5NGdyCdg0BJHXLx7hBy8P1UslD7MkKrWFtiGo+2qwRg2Csu6BQsVQ+kaLKR59j9iheVVBl
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2731.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(396003)(366004)(39860400002)(376002)(451199021)(5660300002)(52536014)(66476007)(66556008)(76116006)(66946007)(41300700001)(4326008)(316002)(66446008)(110136005)(54906003)(2906002)(64756008)(478600001)(71200400001)(7696005)(8676002)(26005)(8936002)(6506007)(186003)(107886003)(83380400001)(82960400001)(38100700002)(122000001)(38070700005)(9686003)(33656002)(55016003)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NXZKNHNJODFzM3J2cTFxRW5nQ3plZW44cWFwTGNTUUV3VTk3ckNxUEc5NWpX?=
 =?utf-8?B?WFJRSlY5UTRYTE1ETnNla3h2cHVBc2U3RDUrcEc1L245WC9qdkt4RUpsWXQ2?=
 =?utf-8?B?eTRMaXZvOHYxOTc0RHpSZ3NVdGVERjNtZ3doNmlUSG9TbEM1cUYrQlZZM3Zk?=
 =?utf-8?B?eEhpZTdrKzUwV1ArRjcxKzlsMUxsY1plRXorMUprdW93UHdwL0NlTFdJUHRx?=
 =?utf-8?B?VjhHL3pRR3ZkSHZnY2NRTlJwQjhiUmxvV2dhRnJLQ1FGQnZvb3RSTTJLdmZ2?=
 =?utf-8?B?aGJJVnZndlFqVmpwUXFBOUplRGdabmoybzlxcEpNYW5DMENWclYxZFFuZ2wz?=
 =?utf-8?B?RXljS3VQbWlVaWNXUk9QYmdYMlFZazRTV3MwT3RjTVQxaG94TzVHczNqb0Jj?=
 =?utf-8?B?SEdIZTNQZWZ0S0VhSnNuUkgyYkgzWTZ1QXJ0eVVlK1d3NWIrcGVQZjExM0pW?=
 =?utf-8?B?N2tyaW82dHRKM3pOT3JiN2RHclo2aG1oL2Zqd1dxU2pWSUdSY2psMEw0cXFR?=
 =?utf-8?B?N0FWSkxzL2pNK0JBcmZ6em1oc05jVmxUaXBySXFTOEFoaTBDc2w5VXVhUmcr?=
 =?utf-8?B?MWYzTG1vdXhMMXRBM2JYVlFFajNTQ2FzaHVZMzNuTW1BcThmNWxJM2x4dFhI?=
 =?utf-8?B?MkhwZ01lM0VEeGxVOXZCMi8wN2J2Y1dHdTl3UFRyTGJ2alBocnZ1dlJXdWVh?=
 =?utf-8?B?WGdlZFhpeTRzZ24wNGRKbzBzOElkWkZJQnZVMUxFOFlIa2hUYm5Ba2VyYXdP?=
 =?utf-8?B?SDBpdnRmZ1F3b0c5U2I5SGJTcy90VkJCajV3RGdScjZPUjF5b0h5UmhVeXpv?=
 =?utf-8?B?UWJTb2E0TXM0TWFxeDRySUFadGZrNTZLYnZVb1FOeitlYkFtVkNrRzlScFNm?=
 =?utf-8?B?Z0MxeklkMnFxYnY2cDlKbFcyeGdWZWl4QmkwOUh2c0dBb0NmUlM5aEU1S2Q3?=
 =?utf-8?B?T3hydlczVk9Ba2k5T0lxdVpydFlGcXI3TWN6STMrVlBybXhTdlhSRnZVRUcy?=
 =?utf-8?B?ajd5d0dZSEVxSVRjcjhyNU5xdUlPVVh2djhkUUhUM2p4KzZtcVR5cVEwa01a?=
 =?utf-8?B?YzA4K0pSaU5qclB4TWVHbldGeXcrcFFhc1Rkc0pORHJWdkxvQ3Q0eVorRWx2?=
 =?utf-8?B?M2JvRHAyRmJXKzkyMXREN2FMRjZnMXd1TXJrVGpnNDhUSHVKRGFGWVJmOHV0?=
 =?utf-8?B?S0Vncm5CYTV5VUc0K0c5UGh3Q08wY2h2eCtrNkgxVHNwSytqSU85WVR2RXVr?=
 =?utf-8?B?TkNKY0JRT2lFZmw3ejNjMlZBbjhGdzlKcm5KTEhYNGtKS0ZSTUVBVEVVbENH?=
 =?utf-8?B?cEJTa2ZlQjNVYXJUUGt5VTB3Uml2SHhzZDVkOU12dG5hL1JhZCtIVmJqNFFs?=
 =?utf-8?B?dm1saENMNVE5UHhPdnBqWk5ISmVaM3BXZDYrQ2FTeUViR2RERXlxMEN2eTBW?=
 =?utf-8?B?QUIzNGk5VjloZmx3SmNCTEdVUXovU0VmcEhJVkFmNDkzOW9nL3hROVJNVEJI?=
 =?utf-8?B?ZzgvbHRZQWJtWDNvaUI3VUpPaE1UNUkrNWhQRXZQbmlqTEtmc2dVN3AyU29n?=
 =?utf-8?B?bVRyY1ZoeEtUWVZnRkFEaXU1NFdHdnN1R1NXckpONGFDK2htYkJpQjZJN1dR?=
 =?utf-8?B?MW1VUzRzcFNrbkdsbmtBS015OTBHYTQyMWNOTHM2L0JJUHU3eG5ObFF5MmRr?=
 =?utf-8?B?MlVoQjRJTEhsTktvUExZeG9mVlZhMHpuZTk5Tk9lODNxaHNTUVl6eTRDTHNS?=
 =?utf-8?B?L3VFWjF5dzl3U2NBeDFGM1VQQTJrUW5PSFFZQWZhcmkzZ01PalZKcGZOdTFs?=
 =?utf-8?B?ZVliTVZlbWg0Q3BhTkZDRFhyVmc4UGdpSTlnbE9UcWViZW4xQWVpMGhiVG5O?=
 =?utf-8?B?em5LMExjVERGZFBMSi9EcEpDQUxFK0N6Q2FUc2ZabVdyRjNtd3lQNFhweUZh?=
 =?utf-8?B?T2VEdjlFUkFOdXNiTU1jMGlXbmVmWWwrMW1tTWxKQnpxbEluN0h0M241WjNa?=
 =?utf-8?B?QWduTnFoeU9RTTFGVFY4d21SRnVyTk13Q3pON3M4cENmdVQvb0UrNktmN1d3?=
 =?utf-8?B?YUFiVmVwR3VCRmN4RVJwUHFMTldpM0NXd3JlZm4zeFZ4OElrQktGbVBJcWti?=
 =?utf-8?Q?BhDDNNG0Y52VQPYfoFptx5dN8?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2731.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0501e294-eae5-4930-924d-08db91ce1c6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2023 13:57:42.9219
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YUKk3SzWm1FF2jLYUM9k8H4Vk9DEhsJrhc58aXIAsPQAzu1SgRiMbsVp+pl/EnAt0S0/SVB4cPgSdJEsvd0dIoFhJen1i93mtGqcAC+rgYk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8212
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

RnJvbTogQnJhbmRlYnVyZywgSmVzc2UgPGplc3NlLmJyYW5kZWJ1cmdAaW50ZWwuY29tPiANClNl
bnQ6IFNhdCwgMjkgSnVsIDIwMjMgMDE6NTkNCj5PbiA3LzI3LzIwMjMgMTo0MyBBTSwgSmVkcnpl
aiBKYWdpZWxza2kgd3JvdGU6DQo+PiBGcm9tOiBHcnplZ29yeiBTemN6dXJlayA8Z3J6ZWdvcnp4
LnN6Y3p1cmVrQGludGVsLmNvbT4NCj4+IA0KPj4gVGhlcmUgd2FzIGFuIGlzc3VlIHdpdGggZXRo
dG9vbCBzdGF0cyB0aGF0DQo+PiBoYXZlIG5vdCBiZWVuIGNsZWFyZWQgYWZ0ZXIgdGMgaGFkIGJl
ZW4gZGVsZXRlZC4NCj4+IFN0YXRzIHByaW50ZWQgYnkgZXRodG9vbCAtUyByZW1haW5lZCB0aGUg
c2FtZSBkZXNwaXRlDQo+PiBxZGljayBoYWQgYmVlbiByZW1vdmVkLCB3aGF0IGlzIGFuIHVuZXhw
ZWN0ZWQgYmVoYXZpb3IuDQo+DQo+cWRpc2MNCj4NCj4+IFN0YXRzIHNob3VsZCBiZSByZXNldGVk
IG9uY2UgcWRpY2sgaXMgcmVtb3ZlZC4NCj4NCj5wbGVhc2UgcmVmbG93IHRvIDc1IGNoYXJzLCBw
bGVhc2UgcmVzdGF0ZSBhbHNvIGFzDQo+U3RhdHMgc2hvdWxkIGJlIHJlc2V0IG9uY2UgdGhlIHFk
aXNjIGlzIHJlbW92ZWQuDQoNClN1cmUsIHRoaXMgd2lsbCBiZSBjb3JyZWN0ZWQuIA0KVGhhbmtz
DQoNCj4NCj4+IA0KPj4gRml4IHRoaXMgYnkgcmVzZXR0aW5nIHN0YXRzIGFmdGVyIGRlbGV0aW5n
IHRjDQo+PiBieSBjYWxsaW5nIGk0MGVfdnNpX3Jlc2V0X3N0YXRzKCkgZnVuY3Rpb24gYWZ0ZXIN
Cj4+IGRpc3Ryb3lpbmcgcWRpc2MuDQo+DQo+ZGVzdHJveWluZw0KPg0KPj4gDQo+PiBTdGVwcyB0
byByZXByb2R1Y2U6DQo+PiANCj4+IDEpIEFkZCBpbmdyZXNzIHJ1bGUNCj4+IHRjIHFkaXNjIGFk
ZCBkZXYgPGV0aFg+IGluZ3Jlc3MNCj4+IA0KPj4gMikgQ3JlYXRlIHFkaXNjIGFuZCBmaWx0ZXIN
Cj4+IHRjIHFkaXNjIGFkZCBkZXYgPGV0aFg+IHJvb3QgbXFwcmlvIG51bV90YyA0IG1hcCAwIDAg
MCAwIDEgMiAyIDMgcXVldWVzIDJAMCAyQDIgMUA0IDFANSBodyAxIG1vZGUgY2hhbm5lbA0KPj4g
dGMgZmlsdGVyIGFkZCBkZXYgPGV0aFg+IHByb3RvY29sIGlwIHBhcmVudCBmZmZmOiBwcmlvIDMg
Zmxvd2VyIGRzdF9pcCA8aXA+IGlwX3Byb3RvIHRjcCBkc3RfcG9ydCA4MzAwIHNraXBfc3cgaHdf
dGMgMg0KPj4gDQo+PiAzKSBSdW4gaXBlcmYgYmV0d2VlbiBjbGllbnQgYW5kIFNVVA0KPj4gaXBl
cmYzIC1zIC1wIDgzMDANCj4+IGlwZXJmMyAtYyA8aXA+IC1wIDgzMDANCj4+IA0KPj4gNCkgQ2hl
Y2sgdGhlIGV0aHRvb2wgc3RhdHMNCj4+IGV0aHRvb2wgLVMgPGV0aFg+IHwgZ3JlcCBwYWNrZXRz
IHwgY29sdW1uDQo+PiANCj4+IDUpIERlbGV0ZSBmaWx0ZXIgYW5kIHFkaXNjDQo+PiB0YyBmaWx0
ZXIgZGVsIGRldiA8ZXRoWD4gcGFyZW50IGZmZmY6DQo+PiB0YyBxZGlzYyBkZWwgZGV2IDxldGhY
PiByb290DQo+PiANCj4+IDYpIENoZWNrIHRoZSBldGh0b29sIHN0YXRzIGFuZCBzZWUgdGhhdCB0
aGV5IGRpZG4ndCBjaGFuZ2UNCj4+IGV0aHRvb2wgLVMgPGV0aFg+IHwgZ3JlcCBwYWNrZXRzIHwg
Y29sdW1uDQo+PiANCj4+IFNpZ25lZC1vZmYtYnk6IEdyemVnb3J6IFN6Y3p1cmVrIDxncnplZ29y
enguc3pjenVyZWtAaW50ZWwuY29tPg0KPj4gU2lnbmVkLW9mZi1ieTogSmVkcnplaiBKYWdpZWxz
a2kgPGplZHJ6ZWouamFnaWVsc2tpQGludGVsLmNvbT4NCj4+IC0tLQ0KPj4gdjI6IE1ha2UgdGhl
IGNvbW1pdCBtc2cgbW9yZSBkZXRhaWxlZA0KPj4gLS0tDQo+PiAgZHJpdmVycy9uZXQvZXRoZXJu
ZXQvaW50ZWwvaTQwZS9pNDBlX21haW4uYyB8IDUgKysrKysNCj4+ICAxIGZpbGUgY2hhbmdlZCwg
NSBpbnNlcnRpb25zKCspDQo+PiANCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5l
dC9pbnRlbC9pNDBlL2k0MGVfbWFpbi5jIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaTQw
ZS9pNDBlX21haW4uYw0KPj4gaW5kZXggMjlhZDE3OTdhZGNlLi5lOGUwM2VkZTE2NzIgMTAwNjQ0
DQo+PiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pNDBlL2k0MGVfbWFpbi5jDQo+
PiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pNDBlL2k0MGVfbWFpbi5jDQo+PiBA
QCAtNTg4NSw2ICs1ODg1LDExIEBAIHN0YXRpYyBpbnQgaTQwZV92c2lfY29uZmlnX3RjKHN0cnVj
dCBpNDBlX3ZzaSAqdnNpLCB1OCBlbmFibGVkX3RjKQ0KPj4gIA0KPj4gIAkvKiBVcGRhdGUgdGhl
IG5ldGRldiBUQyBzZXR1cCAqLw0KPj4gIAlpNDBlX3ZzaV9jb25maWdfbmV0ZGV2X3RjKHZzaSwg
ZW5hYmxlZF90Yyk7DQo+PiArDQo+PiArCS8qIEFmdGVyIGRlc3Ryb3lpbmcgcWRpc2MgcmVzZXQg
YWxsIHN0YXRzIG9mIHRoZSB2c2kgKi8NCj4+ICsJaWYgKCF2c2ktPm1xcHJpb19xb3B0LnFvcHQu
aHcpDQo+PiArCQlpNDBlX3ZzaV9yZXNldF9zdGF0cyh2c2kpOw0KPj4gKw0KPj4gIG91dDoNCj4+
ICAJcmV0dXJuIHJldDsNCj4+ICB9DQoNCg==

